library(shinydashboard)
library(leaflet)
library(DT)

header <- dashboardHeader(
  title = "Secure Medical Referral Way",
  titleWidth = 300
)
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Map", tabName = "Map", icon = icon("map-o")),
    menuItem("Table", tabName = "Table", icon = icon("th")),
    menuItem("Referral-out Ratio", tabName = "HeatmapPlot", icon = icon("area-chart"))
    #,
    #menuItem("Bar", tabName = "Bar", icon = icon("bar-chart")),
    #menuItem("Line", tabName = "Line", icon = icon("line-chart"))
  ),
  width = 300
)
body <- dashboardBody(
  tabItems(
    #1fs tab content
    tabItem(tabName = "Map",
            fluidRow(
              column(width = 9,
                     box(width = NULL, solidHeader = TRUE,
                         leafletOutput("referralmap", height = 550)
                     )
              ),
              column(width = 3,
                     box(width = NULL, status = "warning",
                         uiOutput("hospitalNamesSelect"),
                         checkboxGroupInput("duringDays", "Show",
                                            choices = c(
                                              "1 Day" = "1",
                                              "3 Days" = "3",
                                              "5 Days" = "5",
                                              "7 Days" = "7"
                                            ),
                                            selected = c("1", "3", "5", "7")
                         ),
                         actionButton("zoomButton", "Zoom to fit path")
                     ),
                     box(width = NULL,
                         uiOutput("numDuringDaysTable")
                     )
              ),
              column(width = 12,
                     box(width = NULL, status = "warning",
                         dateRangeInput("date", strong("Date range"), min = as.Date("2014-01-01"),max = as.Date("2016-12-01"), start = as.Date("2014-01-01"), end = as.Date("2016-12-01")),
                         checkboxInput(inputId = "animation", label = strong("Monthly Animation"), value = FALSE),
                         conditionalPanel(condition = "input.animation == true",
                                          sliderInput("timeSlider", "Time Slider", min = as.Date("2014-01-01"),max = as.Date("2016-12-01"),value= as.Date("2014-01-01"))
                         ) 
                         )
              )
            )
    ),
    # 2nd tab content
    tabItem(tabName = "Table",
            fluidPage(
              tabsetPanel(
                id = 'dataset',
                tabPanel("Hospitals Location", DT::dataTableOutput("hospitalsLocationTable")),
                tabPanel("Refer-out Ratio", DT::dataTableOutput("referoutRatioTable")),
                tabPanel("Referral Path", DT::dataTableOutput("ReferralPathTable"))
              )
            )
    ),
    # 3rd tab content
    tabItem(tabName = "HeatmapPlot",
            fluidRow(
              column(width = 12,
                     box(width = NULL, solidHeader = TRUE,
                         plotOutput("referoutRatioHeatmap", height = 400)
                     )
              )
            )
            # ,
            # # 4th tab content
            # tabItem(tabName = "Bar",
            #         h2("Bar tab content")
            # ),
            # # 5th tab content
            # tabItem(tabName = "Line",
            #         h2("Line tab content")
            # )
    )
  )
)

dashboardPage(
  header,
  sidebar,
  body
)