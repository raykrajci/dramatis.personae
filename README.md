
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dramatis.personae

<!-- badges: start -->

<!-- badges: end -->

This package generates a YAML file for gathering authors and their
affiliations then uses that file to generate a list of authors and their
affiliations for manuscripts.

## Installation

You can install the development version of dramatis.personae from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("raykrajci/dramatis.personae")
```

## Example

Generating the list of authors and their affiliations is a two step
process:

``` r
# Generate the YAML file.
# Defaults to "dramatis.personae.yaml" in the working directory.

dramatis.personae::initialize()
#> NULL

# Generate the list of authors and affiliations from the YAML file.

result <- dramatis.personae::generate()

result$authors
#> # A tibble: 3 × 3
#>   auth_number auth                              affl_number
#>         <int> <chr>                             <chr>      
#> 1           1 Sete-Sois, Baltasar X.            1          
#> 2           2 Sete-Luas, Blimunda Y.            1, 2       
#> 3           3 Lourenco de Gusmao, Bartolomeu Z. 2

result$affiliations
#> # A tibble: 2 × 2
#>   affl_number affl_name                                                         
#>         <int> <chr>                                                             
#> 1           1 Convent of Mafra                                                  
#> 2           2 Center for Global Health and Diseases, Case Western Reserve Unive…
```
