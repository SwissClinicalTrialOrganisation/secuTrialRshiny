
<!-- README.md is generated from README.Rmd. Please edit that file -->

# secuTrialRshiny

An R package containing a web app for handling of data from the clinical data management system (CDMS) [secuTrial](https://www.secutrial.com/en/). This package builds on SCTO's data management R package [secuTrialR](https://github.com/SwissClinicalTrialOrganisation/secuTrialR).

## Installing from github with devtools


```r
devtools::install_github("SwissClinicalTrialOrganisation/secuTrialRshiny")
```

## Run the shiny app secuTrialRshiny

Run the app localy on your computer after installation      


```r
library(secuTrialRshiny)
run_shiny()
```

## For contributors

### App structure and conventions

This Shiny app is built in a [modular fashion](https://shiny.rstudio.com/articles/modules.html) as an R package:

* All functions needed to run the app are in the `/R` directory
* You can launch the app with the `run_shiny()` function. The app does not launch if you try to run the `R/app.R` file!
* The app is built in a modular fashion
  * `R/app.R` contains the main UI function `app_UI()` and the main app server function `app_srv()`
  * module functions are saved in `R/mod_*.R` files
  * module UI functions are called `mod_*_UI()`
  * modules server functions are called `mod_*_srv()`
  * supporting functions that do not contain an entire UI or server module are also in the `R/` directory
  * `app_UI()` calls all UI module functions
  * `app_srv()` calls all server module functions

### Reusing modules

Note that each module currently represents a content of a shinydashboard sidebar tab (`shinydashboard::menuItem()`). 
This means that you can reuse the modules from this package in your own custom Shiny dashboards. 
Just add a secuTrialRshiny module to your main app UI as a new `shinydashboard::menuItem()`, 
and call the module from your main server function using `shiny::callModule()`.

### Extending the app

Create a new `R/mod_{module_name}.R` file for the new module. It should contain:

* a module UI function `mod_{module_name}_UI()`
* a module server function `mod_{module_name}_srv()`
  
Example for a module called "mod_newmod": 

```r
## create new file: R/mod_newmod.R
mod_newmod_UI <- function(id, label){
  ## ... some UI code ...
}
mod_newmod_srv <- function(input, output, session, sT_export){
   ## ... some server code ... 
}
```

Then extend `get_modules()` such that it contains an alias of the new module `mod_{module_name}`. 
Here's an example for the fictional "mod_newmod".


```r
## modify existing file: R/get_modules.R
get_modules <- function(){
  ## a list of all module names
  mod <- list(
    ## ... all other modules ...
    newmodule = "mod_newmod" # add this line for "newmod"
  )
  return(mod)
}
```

`get_modules()` is called within the main `app_UI()` and `app_srv()`, and the results are saved in the `mod` object.
`mod` is then referenced to when loading a new module, as you will see below.

Next, you will need to extend `app_UI()` and `app_srv()`, such that they call the new `mod_{module_name}_UI()` and `mod_{module_name}_srv()`

Note that currently all modules represent contents of Shiny dashboard sidebar tabs. The example is based on the assumption that
you are also creating such a module.

You will add the new module UI function as a new menuItem() inside of `app_UI()`. Here is an example for new_module:


```r
## file: R/app.R function app_UI()
menuItem("New sidebar tab module", tabName = mod$newmod, icon = icon("info"))
```

Within `app_srv()`, you will need to call the new module server function. It will go along these lines:


```r
## file: R/app.R function app_srv()
callModule(mod_newmod_srv, mod$newmod, sT_export)
```

That's it. Now build the package, and launch the app with `run_shiny()`.

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
render("vignettes/secuTrialRshiny-vignette.Rmd", output_format=c("pdf_document"))
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
