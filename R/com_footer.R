#' A shiny component generating an HTML footer line
#'
#' This is used to generate a footer line containing info about the
#' file loaded into the shiny app via read_secuTrialR()
#'
#' @param footer_info character containing a string to be encapsulated by the "footer" tag
#' @return html string with a "footer" tag
#' @seealso \code{\link{app_srv}}, \code{\link{run_shiny}}
#' @import shiny
#' @export
#'
com_footer_UI <- function(footer_info){
  HTML(paste0("<footer>", textOutput(footer_info), "</footer>"))
}
