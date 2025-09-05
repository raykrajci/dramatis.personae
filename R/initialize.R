#' Create a dramatis.personae YAML file template.
#'
#' @param file The file path.
#'
#' @returns NULL
#' @export
initialize <- function(file = "dramatis.personae.yaml"){

  assertthat::is.string(file)

  file.create(file)

  assertthat::is.writeable(file)

  template <- list(
    affiliations = list(
      affiliation_1 = list(
        id = "CGHD",
        name = "Center for Global Health and Diseases, Case Western Reserve University"
      ),
      affiliation_2 = list(
        id = "COM",
        name = "Convent of Mafra"
      )
    ),
    authors = list(
      author_1 = list(
        first = "Baltasar",
        middle = "X.",
        last = "Sete-Sois",
        affl = list("COM")
      ),
      author_2 = list(
        first = "Blimunda",
        middle = "Y.",
        last = "Sete-Luas",
        affl = list("CGHD", "COM")
      ),
      author_3 = list(
        first = "Bartolomeu",
        middle = "Z.",
        last= "Lourenco de Gusmao",
        affl = list("CGHD")
      )
    )
  )

  yaml::write_yaml(template, file)

  NULL

}
