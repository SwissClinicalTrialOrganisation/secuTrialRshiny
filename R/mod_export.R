#' Shiny module UI function for data conversion and export
#'
#' This function represents a shiny dashboard UI module that allows users to
#' convert secuTrialRdata to STATA, SAS or SPSS compatible formats, and download
#' them as a zip archive.
#'
#' @param id string containing a namespace identifier
#' @param label string to be used as sidebar tab label
#' @return shiny.tag list object containing the tab item content
#' @seealso \code{\link{mod_export_srv}}
#' @import shiny
#' @import shinydashboard
#' @export
#'
mod_export_UI <- function(id, label) {
  ns <- NS(id)
  # Last tab content / Download
  tabItem(tabName = label,
          fluidRow(
            h2("Download data conversion archives"),
            br()
          ),
          fluidRow(
            h4("Download STATA"),
            downloadButton(ns("downloadDataStata"), "Download dta zip archive"),
            br(),
            br(),
            h4("Download SAS"),
            downloadButton(ns("downloadDataSas"), "Download sas7bdat zip archive"),
            br(),
            br(),
            downloadButton(ns("downloadDataXpt"), "Download xpt v8 zip archive"),
            br(),
            br(),
            h4("Download SPSS"),
            downloadButton(ns("downloadDataSav"), "Download sav zip archive")
          ),
          fluidRow(
            br(), br(),
            com_footer_UI(ns("file_info"))
          )
  )
}

#' Shiny module server function for data conversion and export
#'
#' This function represents a shiny dashboard server module that allows users to
#' convert secuTrialRdata to STATA, SAS or SPSS compatible formats, and download
#' them as a zip archive.
#'
#' @param input session's input object
#' @param output session's output object
#' @param session session object environment
#' @param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#' @param vals_upload reactivevalues list containing the output of \code{\link{mod_upload_srv}}
#' @seealso \code{\link{mod_export_UI}}
#' @import shiny
#' @export
#'
mod_export_srv <- function(input, output, session, sT_export, vals_upload) {
  output$downloadDataStata <- downloader(file_name = "stata.zip", format = "dta", sT_export)
  output$downloadDataSas <- downloader(file_name = "sas7bdat.zip", format = "sas", sT_export)
  output$downloadDataXpt <- downloader(file_name = "xpt.zip", format = "xpt", sT_export)
  output$downloadDataSav <- downloader(file_name = "sav.zip", format = "sav", sT_export)
  output$file_info <- renderText({
    vals_upload$file_info
  })
}
