#' Shiny module UI function for casenode monitoring
#'
#' This function represents a shiny dashboard UI module that allows users to
#' generate a list of random participants for monitoring.
#' The list can be downloaded as a csv file.
#'
#'@param id string containing a namespace identifier
#'@param label string to be used as sidebar tab label
#'@return shiny.tag list object containing the tab item content
#'@seealso \code{\link{mod_monitorcn_srv}}
#'@export
#'
mod_monitorcn_UI <- function(id, label) {
  ns <- NS(id)
  tabItem(tabName = label,
          fluidRow(
            h2("Return random monitoring cases"),
            br()
          ),
          fluidRow(
            selectInput(inputId = ns("centre"), label = "Specify centre",
                        choices = c("all")),
            dateInput(inputId = ns("dateafter"), label = "Return cases after date",
                      value = "1900-01-01", width = 190),
            numericInput(inputId = ns("seednumber"), label = "Seed", value = 1, width = 100),
            sliderInput(inputId = ns("percentage"), label = "Specify percentage of cases",
                        min = 1, max = 99, value = 10, width = 400),
            hr(),
            actionButton(inputId = ns("create_mon_table"), label = "Submit configuration",
                         icon("paper-plane"))
          ),
          fluidRow(
            downloadButton(ns("download_monitoring_cases_csv"), "Cases"),
            downloadButton(ns("download_monitoring_config_csv"), "Config"),
            hr(),
          ),
          fluidRow(
            box(
              tableOutput(ns("monitoring_cases")),
              width = 4
            )
          ),
          fluidRow(
            br(), br(),
            com_footer_ui(ns("file_info"))
          )
  )
}

#' Shiny module server function for casenode monitoring
#'
#' This function represents a shiny dashboard server module that allows users to
#' generate a list of random participants for monitoring.
#' The list can be downloaded as a csv file.
#'
#'@param input session's input object
#'@param output session's output object
#'@param session session object environment
#'@param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#'@seealso \code{\link{mod_monitorcn_UI}}
#'@export
#'
mod_monitorcn_srv <- function(input, output, session, sT_export, vals_upload) {
  # reactive button
  rdm_cases <- eventReactive(input$create_mon_table, {
    perc <- input$percentage / 100
    rand_participants <- return_random_participants(sT_export(), seed = input$seednumber,
                                                    centres = input$centre,
                                                    date = input$dateafter,
                                                    percent = perc)
    rand_participants$participants
  })

  output$monitoring_cases <- renderTable({
    rdm_cases()
  })

  output$download_monitoring_cases_csv <- downloadHandler(

    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      "monitoring_cases.csv"
    },

    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write.csv(rdm_cases(), file = file, row.names = FALSE, quote = FALSE)
    }
  )

  output$download_monitoring_config_csv <- downloadHandler(

    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      "monitoring_cases_config.csv"
    },

    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      write(
        paste(c(
          paste0("percentage: ", input$percentage),
          paste0("seed: ", input$seednumber),
          paste0("centre(s): ", input$centre),
          paste0("after date: ", as.character.Date(input$dateafter)))),
        sep = ",", file = file, append = TRUE
      )
    }
  )

  output$file_info <- renderText({
    vals_upload$file_info
  })
}
