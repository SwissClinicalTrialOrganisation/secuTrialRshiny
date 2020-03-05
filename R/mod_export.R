#' Shiny module UI function for data conversion and export
#'
#' This function represents a shiny dashboard UI module that allows users to
#' convert secuTrialRdata to STATA, SAS or SPSS compatible formats, and download
#' them as a zip archive.
#'
#'@param id string containing a namespace identifier
#'@param label string to be used as sidebar tab label
#'@return shiny.tag list object containing the tab item content
#'@seealso \code{\link{mod_export}}
#'@export
#'
mod_export_UI <- function(id, label) {
  ns <- NS(id)
  # Last tab content / Download
  tabItem(tabName = label,
          h2("Download data conversion archives"),
          br(),
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
  )
}

#' Shiny module server function for data conversion and export
#'
#' This function represents a shiny dashboard server module that allows users to
#' convert secuTrialRdata to STATA, SAS or SPSS compatible formats, and download
#' them as a zip archive.
#'
#'@param input session's input object
#'@param output session's output object
#'@param session session object environment
#'@param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#'@seealso \code{\link{mod_export_UI}}
#'@export
#'
mod_export <- function(input, output, session, sT_export) {
  output$downloadDataStata <- downloader(file_name = "stata.zip", format = "dta", sT_export)
  output$downloadDataSas <- downloader(file_name = "sas7bdat.zip", format = "sas", sT_export)
  output$downloadDataXpt <- downloader(file_name = "xpt.zip", format = "xpt", sT_export)
  output$downloadDataSav <- downloader(file_name = "sav.zip", format = "sav", sT_export)
}
