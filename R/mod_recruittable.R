#' Shiny module UI function for recruitment table display
#'
#' This function represents a shiny dashboard UI module that allows users to
#' view a secuTrialR recruitment table.
#'
#'@param id string containing a namespace identifier
#'@param label string to be used as sidebar tab label
#'@return shiny.tag list object containing the tab item content
#'@seealso \code{\link{mod_recruittable_srv}}
#'@export
#'
mod_recruittable_UI <- function(id, label) {
  ns <- NS(id)

  # Third tab content
  tabItem(tabName = label,
          h2(id = ns("title"), "Study recruitment"),
          box(
            tableOutput(ns("annual_recruitment"))
          )
  )
}

#' Shiny module server function for recruitment table display
#'
#' This function represents a shiny dashboard server module that allows users to
#' view a secuTrialR recruitment table.
#'
#'@param input session's input object
#'@param output session's output object
#'@param session session object environment
#'@param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#'@seealso \code{\link{mod_recruittable_UI}}
#'@export
#'
mod_recruittable_srv <- function(input, output, session, sT_export) {
  output$annual_recruitment <- renderTable({
    annual_recruitment(sT_export())
  })
}
