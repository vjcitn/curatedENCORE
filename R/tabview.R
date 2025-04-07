#' explore workspace tables
#' @import AnVIL
#' @import shiny
#' @import DT
#' @export
tabview = function() {
 tabs = avtables()
 ui = fluidPage(
  sidebarLayout(
   sidebarPanel(
    helpText("table overview for curatedENCORE"),
    radioButtons("picked", "tables", choices=tabs$table, selected="anvil_project"), width=2
    ),
  mainPanel(
   tabsetPanel(
    tabPanel("data", 
     uiOutput("colbut"),
     DT::dataTableOutput("thetab")
    ),
    tabPanel("about", 
     verbatimTextOutput("desc"),
     verbatimTextOutput("sess"),
     verbatimTextOutput("line")
    )
   )
  )
 )
)
server = function(input, output) {
 output$desc = renderPrint(packageDescription("curatedENCORE"))
 output$sess = renderPrint(sessionInfo())
 thetabgen = reactive({
  tab = avtable(input$picked)
  list(tab=as.data.frame(tab), nms=colnames(tab))
  })
 getsel = reactive({
   tab = thetabgen()$tab
   print(input$thetab_rows_selected)
   })
 output$thetab = DT::renderDataTable({
  validate(need(length(input$curcols)>0, "waiting for columns"))
  thetabgen()$tab[, input$curcols]
  })
 output$colbut = renderUI({
  opts = thetabgen()$nms
  checkboxGroupInput("curcols", "vbls", choices=opts, selected=opts[1:3], inline=TRUE)
 })
 output$line = renderPrint({ getsel() })
 }
 runApp(list(ui=ui, server=server))
} # function

	
