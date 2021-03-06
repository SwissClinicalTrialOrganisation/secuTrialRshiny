#' Shiny module UI function for recruitment plot display
#'
#' This function represents a shiny dashboard UI module that allows users to
#' view a secuTrialR recruitment plot.
#'
#' @param id string containing a namespace identifier
#' @param label string to be used as sidebar tab label
#' @return shiny.tag list object containing the tab item content
#' @seealso \code{\link{mod_recruitplot_srv}}
#' @import shiny
#' @import shinydashboard
#' @export
#'
mod_recruitplot_UI <- function(id, label) {
  ns <- NS(id)
  tabItem(tabName = label,
          fluidRow(
            h2(id = ns("title"), "Study recruitment"),
            br()
          ),
          fluidRow(
            box(
              plotOutput(ns("recruitment_plot"), height = 500, width = 900), width = 1000
            )
          ),
          fluidRow(
            downloadButton(ns("downloadDataRecruitmentPlot"), "Download pdf")
          ),
          fluidRow(
            br(), br(),
            com_footer_UI(ns("file_info"))
          )
  )
}

#' Shiny module server function for recruitment plot display
#'
#' This function represents a shiny dashboard server module that allows users to
#' view a secuTrialR recruitment plot.
#'
#' @param input session's input object
#' @param output session's output object
#' @param session session object environment
#' @param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#' @param vals_upload reactivevalues list containing the output of \code{\link{mod_upload_srv}}
#' @seealso \code{\link{mod_recruitplot_UI}}
#' @import shiny
#' @importFrom secuTrialR plot_recruitment
#' @importFrom grDevices pdf dev.off
#' @export
#'
mod_recruitplot_srv <- function(input, output, session, sT_export, vals_upload) {
  output$downloadDataRecruitmentPlot <- downloadHandler(
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      "recruitment_plot.pdf"
    },
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      pdf(file = file)
      plot_recruitment(sT_export())
      dev.off()
    }
  )
  output$recruitment_plot <- renderPlot({
    plot_recruitment(sT_export())
  })

  output$file_info <- renderText({
    vals_upload$file_info
  })
}
