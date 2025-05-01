#' explore workspace tables
#' @rawNamespace import(AnVIL , except="tags")
#' @rawNamespace import(shiny, except=c("dataTableOutput", "renderDataTable"))
#' @import DT
#' @export
tabview = function() {
 knownTabs = c("anvil_biosample", "donor", "project", "anvil_project", "file", 
"anvil_file", "activity", "anvil_activity")
 colhelper = list(anvil_project = c("import:timestamp", "title", 
                    "registered_identifier.items", "funded_by.items"),
                  anvil_biosample = c("anvil_biosample_id", "import:timestamp",
                    "donor_age_at_collection_lower_bound", 
                    "donor_age_at_collection_unit"),
                  donor = c("donor_id", "donor_type", "phenotypic_sex", "organism_type"),
                  project = c("project_id", "principal_investigator", "title", "funded_by"),
	          file = c("file_id", "file_format", "file_ref", "associated_biosample_id.items"),
                  anvil_file = c("file_format", "file_ref", "file_name", "reference_assembly.items"),
                  activity = c("activity_type", "used_biosample_id.items"), 
                  anvil_activity=c("activity_type", "anvil_activity_id"))
   
 tabs = avtables()
 ui = fluidPage(
  sidebarLayout(
   sidebarPanel(
    helpText("table overview for curatedENCORE"),
    radioButtons("picked", "tables", choices=tabs$table, selected="project"), width=2
    ),
  mainPanel(
   tabsetPanel(
    tabPanel("data", 
     uiOutput("colbut"),
     verbatimTextOutput("tabrep"),
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
  ans = thetabgen()$tab[, input$curcols]
  datatable(ans, filter = list(position = 'top', clear = FALSE))
  })
 output$colbut = renderUI({
  opts = thetabgen()$nms
  validate(need(length(colhelper[[input$picked]])>0, "waiting for column selection"))
  checkboxGroupInput("curcols", "vbls", choices=opts, selected=colhelper[[input$picked]], inline=TRUE)
 })
 output$tabrep = renderPrint({
  tab = thetabgen()$tab
   if (input$picked == "file") stats = table(tab[["file_format"]])
   else if (input$picked == "anvil_file") stats = table(tab[["file_format"]])
   else if (input$picked == "activity") stats = table(tab[["activity_type"]])
   else if (input$picked == "anvil_activity") stats = table(tab[["activity_type"]])
   else stats = sprintf("number of records: %d", nrow(tab))
   stats
 })
 output$line = renderPrint({ getsel() })
 }
 runApp(list(ui=ui, server=server))
} # function

	
