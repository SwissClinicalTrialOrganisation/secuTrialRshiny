#' Shiny module UI function for visit plan display
#'
#' This function represents a shiny dashboard UI module that allows users to
#' view a plot of the visit plan.
#'
#'@param id string containing a namespace identifier
#'@param label string to be used as sidebar tab label
#'@return shiny.tag list object containing the tab item content
#'@seealso \code{\link{mod_visitplan_srv}}
#'@export
#'
mod_visitplan_UI <- function(id, label) {
  ns <- NS(id)
  tabItem(tabName = label,
          h2("Visit plan"),
          box(
            plotOutput(ns("visit_structure"), height = 500, width = 900),
            width = 1000
          )
  )
}

#' Shiny module server function for visit plan display
#'
#' This function represents a shiny dashboard server module that allows users to
#' view a plot of the visit plan.
#'
#'@param input session's input object
#'@param output session's output object
#'@param session session object environment
#'@param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#'@seealso \code{\link{mod_visitplan_UI}}
#'@export
#'
mod_visitplan_srv <- function(input, output, session, sT_export) {
  output$visit_structure <- renderPlot({
    plot(visit_structure(sT_export()))
  })
}
