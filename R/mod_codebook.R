#' Shiny module UI function for codebook display
#'
#' This function represents a shiny dashboard UI module that allows users to
#' display a codebook of a secuTrialRdata object.
#'
#'@param id string containing a namespace identifier
#'@param label string to be used as sidebar tab label
#'@return shiny.tag list object containing the tab item content
#'@seealso \code{\link{mod_codebook_srv}}
#'@export
#'
mod_codebook_UI <- function(id, label) {
  ns <- NS(id)
  # seventh tab codebook
  tabItem(tabName = label,
          h2("Codebook"),
          tabsetPanel(
            tabPanel("Forms", tableOutput(ns("forms"))),
            tabPanel("Questions", tableOutput(ns("questions"))),
            tabPanel("Items", tableOutput(ns("items"))),
            tabPanel("Centres", tableOutput(ns("centres"))),
            tabPanel("Cases", tableOutput(ns("cases"))),
            tabPanel("Visitplan", tableOutput(ns("visitplan")))
          )
  )
}

#' Shiny module server function for codebook display
#'
#' This function represents a shiny dashboard server module that allows users to
#' display a codebook of a secuTrialRdata object.
#'
#'@param input session's input object
#'@param output session's output object
#'@param session session object environment
#'@param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#'@seealso \code{\link{mod_codebook_UI}}
#'@export
#'
mod_codebook_srv <- function(input, output, session, sT_export) {
  output$forms <- renderTable({
    sT_export()[[sT_export()$export_options$meta_names$forms]]
  })

  output$questions <- renderTable({
    sT_export()[[sT_export()$export_options$meta_names$questions]]
  })

  output$items <- renderTable({
    sT_export()[[sT_export()$export_options$meta_names$items]]#[cols]
  })

  output$centres <- renderTable({
    sT_export()[[sT_export()$export_options$meta_names$centres]]
  })

  output$cases <- renderTable({
    sT_export()[[sT_export()$export_options$meta_names$casenodes]]#[cols]
  })

  output$visitplan <- renderTable({
    sT_export()[[sT_export()$export_options$meta_names$visitplan]]
  })
}
