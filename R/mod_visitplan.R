#' Shiny module UI function for visit plan display
#'
#' This function represents a shiny dashboard UI module that allows users to
#' view a plot of the visit plan.
#'
#' @param id string containing a namespace identifier
#' @param label string to be used as sidebar tab label
#' @return shiny.tag list object containing the tab item content
#' @seealso \code{\link{mod_visitplan_srv}}
#' @import shiny
#' @import shinydashboard
#' @export
#'
mod_visitplan_UI <- function(id, label) {
  ns <- NS(id)
  tabItem(tabName = label,
          fluidRow(
            h2("Visit plan"),
            br()
          ),
          fluidRow(
            box(
              plotOutput(ns("visit_structure"), height = 500, width = 900),
              width = 1000
            )
          ),
          fluidRow(
            br(), br(),
            com_footer_UI(ns("file_info"))
          )
  )
}

#' Shiny module server function for visit plan display
#'
#' This function represents a shiny dashboard server module that allows users to
#' view a plot of the visit plan.
#'
#' @param input session's input object
#' @param output session's output object
#' @param session session object environment
#' @param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#' @param vals_upload reactivevalues list containing the output of \code{\link{mod_upload_srv}}
#' @seealso \code{\link{mod_visitplan_UI}}
#' @import shiny
#' @importFrom secuTrialR visit_structure
#' @importFrom graphics plot
#' @export
#'
mod_visitplan_srv <- function(input, output, session, sT_export, vals_upload) {
  output$visit_structure <- renderPlot({
    plot(visit_structure(sT_export()))
  })
  output$file_info <- renderText({
    vals_upload$file_info
  })
}
