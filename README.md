
<!-- README.md is generated from README.Rmd. Please edit that file -->


# secuTrialR ![travis](https://api.travis-ci.com/SwissClinicalTrialOrganisation/secuTrialR.svg?branch=master) [![codecov](https://codecov.io/github/SwissClinicalTrialOrganisation/secuTrialR/branch/master/graphs/badge.svg)](https://codecov.io/github/SwissClinicalTrialOrganisation/secuTrialR) [![](https://img.shields.io/badge/dev%20version-0.8.6-blue.svg)](https://github.com/SwissClinicalTrialOrganisation/secuTrialR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/SwissClinicalTrialOrganisation/secuTrialR?branch=master&svg=true)](https://ci.appveyor.com/project/SwissClinicalTrialOrganisation/secuTrialR)


An R package to handle data from the clinical data management system (CDMS) [secuTrial](https://www.secutrial.com/en/).

## Installing from github with devtools


```r
devtools::install_github("SwissClinicalTrialOrganisation/secuTrialRshiny")
```


## For contributors
### Testing with devtools


```r
# run tests
devtools::test("secuTrialRshiny")
# spell check -> will contain some technical terms beyond the below list which is fine
ignore_words <- c("AdminTool", "allforms", "casenodes", "CDMS", "codebook",
                  "codebooks", "datetime" ,"dir" ,"Hmisc" ,"igraph",
                  "labelled", "mnp", "savedforms", "secutrial", "secuTrial", 
                  "secuTrialdata", "tcltk", "tibble")
devtools::spell_check("secuTrialRshiny", ignore = ignore_words)
```

### Linting with lintr


```r
# lint the package -> should be clean
library(lintr)
lint_package("secuTrialRshiny", linters = with_defaults(camel_case_linter = NULL,
                                                   object_usage_linter = NULL,
                                                   line_length_linter(125)))
```

### Building the vignette

```r
library(rmarkdown)
render("vignettes/secuTrialRshiny-package-vignette.Rmd", output_format=c("pdf_document"))
```

### Generating the README file

The README file contains both standard text and interpreted R code. It must therefore be compiled. Changes should be made in the `README.Rmd` file and the file "knited" with R. This is easiest with RStudio, but other methods are available.


```r
library(knitr)
knit("README.Rmd")
```

### Guidelines for contributors

Requests for new features and bug fixes should first be documented as an [Issue](https://github.com/SwissClinicalTrialOrganisation/secuTrialRshiny/issues) on GitHub.
Subsequently, in order to contribute to this R package you should fork the main repository.
After you have made your changes please run the 
[tests](README.md#testing-with-devtools)
and 
[lint](README.md#linting-with-lintr) your code as 
indicated above. Please also increment the version number and recompile the `README.md` to increment the dev-version badge (requires installing the package after editing the `DESCRIPTION` file). If all tests pass and linting confirms that your 
coding style conforms you can send a pull request (PR). Changes should also be mentioned in the `NEWS` file.
The PR should have a description to help the reviewer understand what has been 
added/changed. New functionalities must be thoroughly documented, have examples 
and should be accompanied by at least one [test](tests/testthat/) to ensure long term 
robustness. The PR will only be reviewed if all travis checks are successful. 
The person sending the PR should not be the one merging it.

A depiction of the core functionalities for loading can be found [here](inst/extdata/graphics/secuTrialR.png).
