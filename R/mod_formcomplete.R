#' Shiny module UI function for form completeness monitoring
#'
#' This function represents a shiny dashboard UI module that allows users to
#' view a form completeness table.
#'
#'@param id string containing a namespace identifier
#'@param label string to be used as sidebar tab label
#'@return shiny.tag list object containing the tab item content
#'@seealso \code{\link{mod_formcomplete}}
#'@export
#'
mod_formcomplete_UI <- function(id, label) {
  ns <- NS(id)
  tabItem(tabName = label,
          h2("Form completeness"),
          #checkboxInput(inputId = ns("percent"), label = "Percent", value = TRUE),
          materialSwitch(inputId = ns("percent"), label = "Percent switch",
                         value = TRUE, status = "danger"),
          #checkboxInput(inputId = ns("counts"), label = "Counts", value = TRUE),
          materialSwitch(inputId = ns("counts"), label = "Counts",
                         value = TRUE, status = "danger"),
          #checkboxInput(inputId = "rmat", label = "Remove audit trail (at) forms"),
          materialSwitch(inputId = ns("rmat"), label = "Remove audit trail (at) forms",
                         value = TRUE, status = "danger"),
          box(
            tableOutput(ns("form_completeness_perc")),
            width = 300
          ),
          box(
            tableOutput(ns("form_completeness_count")),
            width = 250
          )
  )
}

#' Shiny module server function for form completeness monitoring
#'
#' This function represents a shiny dashboard server module that allows users to
#' view a form completeness table.
#'
#'@param input session's input object
#'@param output session's output object
#'@param session session object environment
#'@param sT_export secuTrialdata object generated e.g. with secuTrialR::read_secuTrial()
#'@seealso \code{\link{mod_formcomplete_UI}}
#'@export
#'
mod_formcomplete <- function(input, output, session, sT_export) {
  output$form_completeness_count <- renderTable({
    if (input$counts) {
      table <- form_status_summary(sT_export())
      names <- names(table)
      names_count <- names[! grepl(names, pattern = ".percent")]
      if (input$rmat) {
        table <- table[which(! grepl(table$form_name, pattern = "^at")), ]
        table %>% select(names_count)
      } else {
        table %>% select(names_count)
      }
    }
  })
  output$form_completeness_perc <- renderTable({
    if (input$percent) {
      table <- form_status_summary(sT_export())
      names <- names(table)
      names_perc <- names[grepl(names, pattern = ".percent")]
      names_perc <- c("form_name", names_perc)
      if (input$rmat) {
        table <- table[which(! grepl(table$form_name, pattern = "^at")), ]
        table %>% select(names_perc)
      } else {
        table %>% select(names_perc)
      }
    }
  })
}
