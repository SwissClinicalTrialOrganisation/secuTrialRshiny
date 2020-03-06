#' Launches the secuTrialRshiny Shiny web app
#'
#' You can run the web application by calling the run_shiny() function.
#'
#' @seealso \code{\link{app_srv}}, \code{\link{app_ui}}
#' @export
#'
run_shiny <- function(){
  ## make resources available globally from non standard location
  addResourcePath("www", system.file("www", package = "secuTrialRshiny"))
  shiny_app <- shinyApp(ui = app_ui, server = app_srv)
  return(shiny_app)
}
