#' Retrieves a list of style settings
#'
#' @param style string defining the css style to be used for the shiny app
#' @return list of strings containing style settings
#' @seealso \code{\link{app_ui}}, \code{\link{app_srv}}
#' @export
#'
get_style <- function(style = c("scto", "dkf")){
  style <- match.arg(style, several.ok = FALSE)
  if (style == "scto"){
    style_settings <- list(
      id = "scto",
      logo = "www/scto_logo.svg",
      logo_title = "",
      dark_col = "#e4f1fa",
      light_col = "#ba1e2b",
      skin = "blue" # do not change this - css depends on it
    )
  } else if (style == "dkf"){
    style_settings <- list(
      id = "dkf",
      logo = "www/dkf_logo.png",
      logo_title = "",
      dark_col = "#e4f1fa",
      light_col = "#ba1e2b",
      skin = "blue" # do not change this - css depends on it
    )
  }
  return(style_settings)
}
