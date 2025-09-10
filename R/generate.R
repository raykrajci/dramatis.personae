#' Generate a list of authors and their affiliations from a dramatis.personae YAML file.
#'
#' @param file The file path.
#'
#' @returns A list containing a list of authors and a list of affiliations.
#' @export
generate <- function(file = "dramatis.personae.yaml"){

  assertthat::is.string(file)
  assertthat::is.readable(file)

  temp <- yaml::read_yaml(file)

  affiliations <- dplyr::bind_rows(temp$affiliations) |>
    dplyr::rename_with(\(col) paste("affl", col, sep = "_"), dplyr::everything())

  authors <- dplyr::bind_rows(temp$authors) |>
    purrr::when(
      !"middle" %in% names(.) ~ dplyr::mutate(. , middle = NA_character_), #Add "middle" if it doesn't exist
      TRUE ~ . #Otherwise, return as-is
    ) |>
    tidyr::nest(affl = affl) |>
    dplyr::mutate(number = dplyr::row_number()) |>
    tidyr::unnest(affl) |>
    dplyr::rename_with(\(col) paste("auth", col, sep = "_"), dplyr::everything())

  temp <- dplyr::full_join(authors, affiliations, by = dplyr::join_by(auth_affl == affl_id)) |>
    tidyr::nest(authors = dplyr::starts_with("auth")) |>
    dplyr::mutate(affl_number = dplyr::row_number()) |>
    tidyr::unnest(authors) |>
    dplyr::arrange(auth_number, affl_number)

  authors <- temp |>
    dplyr::select(auth_number, auth_first, auth_middle, auth_last, affl_number) |>
    dplyr::group_by(auth_number, auth_first, auth_middle, auth_last) |>
    dplyr::summarise(affl_number = paste(as.character(affl_number), collapse = ", ")) |>
    dplyr::ungroup() |>
    dplyr::mutate(auth = stringr::str_trim(paste0(auth_last, ", ", auth_first, " ", auth_middle))) |>
    dplyr::select(auth_number, auth, affl_number)

  affiliations <- temp |>
    dplyr::select(affl_number, affl_name) |>
    dplyr::distinct()

  list(authors = authors,
       affiliations = affiliations)

}
