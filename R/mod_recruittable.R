#' Shiny module UI function for recruitment table display
#'
#' This function represents a shiny dashboard UI module that allows users to
#' view a secuTrialR recruitment table.
#'
#' @param id string containing a namespace identifier
#' @param label string to be used as sidebar tab label
#' @return shiny.tag list object containing the tab item content
#' @seealso \code{\link{mod_recruittable_srv}}
#' @import shiny
#' @import shinydashboard
#' @export
#'
mod_recruittable_UI <- function(id, label) {
  ns <- NS(id)

  # Third tab content
  tabItem(tabName = label,
          fluidRow(
            h2(id = ns("title"), "Study recruitment"),
            br()
          ),
          fluidRow(
            box(
              tableOutput(ns("annual_recruitment"))
            )
          ),
          fluidRow(
            br(), br(),
            com_footer_UI(ns("file_info"))
          )
  )
}

#' Shiny module server function for recruitment table display
#'
#' This function represents a shiny dashboard server module that allows users to
#' view a secuTrialR recruitment table.
#'
#' @param input session's input object
#' @param output session's output object
#' @param session session object environment
#' @param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#' @param vals_upload reactivevalues list containing the output of \code{\link{mod_upload_srv}}
#' @seealso \code{\link{mod_recruittable_UI}}
#' @import shiny
#' @importFrom secuTrialR annual_recruitment
#' @export
#'
mod_recruittable_srv <- function(input, output, session, sT_export, vals_upload) {
  output$annual_recruitment <- renderTable({
    annual_recruitment(sT_export())
  })
  output$file_info <- renderText({
    vals_upload$file_info
  })
}
