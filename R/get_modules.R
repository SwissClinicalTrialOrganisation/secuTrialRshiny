#' Retrieves a list of all module aliases
#'
#' Module aliases retrieved via get_modules() are used to define module IDs in shiny::callModule(),
#' and are also used as tabnames for the sidebar, and for the shiny UI label and id.
#'
#' @return list of strings containing module aliases
#' @seealso \code{\link{app_ui}}, \code{\link{app_srv}}
#' @export
#'
get_modules <- function(){
  # a list of all module names
  mod <- list(
    upload = "mod_upload",
    recruitplot = "mod_recruitplot",
    recruittable = "mod_recruittable",
    formcomplete = "mod_formcomplete",
    visitplan = "mod_visitplan",
    monitorcn = "mod_monitorcn",
    codebook = "mod_codebook",
    export = "mod_export"
  )
  return(mod)
}
