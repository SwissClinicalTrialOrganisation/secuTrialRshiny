#' secuTrialdata converter and download handler
#'
#' This is an internal helper function allowing conversion and download of secuTrialdata object
#' using a shiny::downloadHandler(). Supported file formats are the ones listed in secuTrialR::write_secuTrial().
#'
#'@param file_name string containing a file name, including the extension
#'@param format string containing a format identifier for secuTrialR::write_secuTrial()
#'@param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#'@seealso \code{\link{mod_export}}
#'
downloader <- function(file_name, format, sT_export) {
  downloadHandler(
    tdir <- tempdir(),
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      file_name
    },
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write_secuTrial(sT_export(), format = format, path = tdir)
      # exception handling for sas7bdat
      if (format == "sas") format <- "sas7bdat"
      dta_loc <- list.files(path = tdir, full.names = TRUE, pattern = paste0(format, "$"))
      # -j prevents keeping directory structure
      zip(zipfile = file, files = dta_loc, flags = "-j")
    }
  )
}
