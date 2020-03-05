#' Main shiny UI function for secuTrialRshiny
#'
#' Controls the general appearance, header, sidebar, body, tabs with modules, etc.
#'
#' @return shiny.tag list object containing the dashboard page
#' @seealso \code{\link{app_server}}, \code{\link{run_shiny}}
#' @export
#'
app_ui <- function(){
  # get all module names
  mod <- get_modules()
  # create dashboard page
  dashboardPage(skin = "red",
                dashboardHeader(title = "SCTO - secuTrialR"),
                dashboardSidebar(
                  sidebarMenu(
                    # set icon colors
                    tags$style(".fa-upload {color:#dd4b39}"),
                    tags$style(".fa-signal {color:#dd4b39}"),
                    tags$style(".fa-table {color:#dd4b39}"),
                    tags$style(".fa-percent {color:#dd4b39}"),
                    tags$style(".fa-calendar-alt {color:#dd4b39}"),
                    tags$style(".fa-dice {color:#dd4b39}"),
                    tags$style(".fa-book {color:#dd4b39}"),
                    tags$style(".fa-download {color:#dd4b39}"),
                    tags$style(".fa-paper-plane {color:#dd4b39}"),
                    tags$style(".fa-lightbulb {color:#dd4b39}"),
                    # define sidebar menu items
                    menuItem("Upload", tabName = mod$upload, icon = icon("upload")),
                    menuItem("Recruitment plot", tabName = mod$recruitplot, icon = icon("signal")),
                    menuItem("Recruitment table", tabName = mod$recruittable, icon = icon("table")),
                    menuItem("Form completeness", tabName = mod$formcomplete, icon = icon("percent")),
                    menuItem("Visit plan", tabName = mod$visitplan, icon = icon("calendar-alt")),
                    menuItem("Monitoring cases", tabName = mod$monitorcn, icon = icon("dice")),
                    menuItem("Codebook", tabName = mod$codebook, icon = icon("book")),
                    menuItem("STATA - SAS - SPSS", tabName = mod$export, icon = icon("download"))
                  )
                ),
                dashboardBody(
                  tabItems(
                    # fill dashboard body contents with module UI functions
                    mod_upload_UI(mod$upload, label = mod$upload),
                    mod_recruitplot_UI(mod$recruitplot, label = mod$recruitplot),
                    mod_recruittable_UI(mod$recruittable, label = mod$recruittable),
                    mod_formcomplete_UI(mod$formcomplete, label = mod$formcomplete),
                    mod_visitplan_UI(mod$visitplan, label = mod$visitplan),
                    mod_monitorcn_UI(mod$monitorcn, label = mod$monitorcn),
                    mod_codebook_UI(mod$codebook, label = mod$codebook),
                    mod_export_UI(mod$export, label = mod$export)
                  )
                )
  )
}

#' Main Shiny server function for secuTrialRshiny
#'
#' Calls all modules required by app_ui, and passes on relevant data.
#'
#' @param input session's input object
#' @param output session's output object
#' @seealso \code{\link{app_ui}}, \code{\link{run_shiny}}
#' @export
#'
app_server <- function(input, output) {
  # get all module names
  mod <- get_modules()
  # init the sT export reactive Val
  sT_export <- reactiveVal()
  # call all server modules
  callModule(mod_upload, mod$upload, sT_export)
  callModule(mod_recruitplot, mod$recruitplot, sT_export)
  callModule(mod_recruittable, mod$recruittable, sT_export)
  callModule(mod_formcomplete, mod$formcomplete, sT_export)
  callModule(mod_visitplan, mod$visitplan, sT_export)
  callModule(mod_monitorcn, mod$monitorcn, sT_export)
  callModule(mod_codebook, mod$codebook, sT_export)
  callModule(mod_export, mod$export, sT_export)
}
