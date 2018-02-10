library(shinydashboard)
library(leaflet)
library(plyr)
library(dplyr)
library(rgeos)
library(rgdal)
library(data.table)
library(sp)
library(DT)
library(geosphere)
library(htmltools)
library(maps)
library(ggplot2)
library(reshape2)
library(RColorBrewer)
library(seriation)
library(scales)
library(curl) # make the jsonlite suggested dependency explicit
library(showtext)
showtext_auto(enable = TRUE)
font_add("BiauKai", "Kaiu.ttf")

#doInstall <- FALSE# Change to FALSE if you don't want packages installed.
#toInstall <- c("ggplot2", "reshape2", "RColorBrewer", "seriation")
#if(doInstall){install.packages(toInstall, repos = "http://cran.us.r-project.org")}
#lapply(toInstall, library, character.only = TRUE)

# 1=South, 2=East, 3=West, 4=North
dirColors <-c("1"="#595490", "2"="#527525", "3"="#A93F35", "4"="#BA48AA")

# Download data from the Twin Cities Metro Transit API
# http://svc.metrotransit.org/NexTrip/help
getMetroData <- function(path) {
  url <- paste0("http://svc.metrotransit.org/NexTrip/", path, "?format=json")
  jsonlite::fromJSON(url)
}

# Load static trip and shape data
#trips  <- readRDS("metrotransit-data/rds/trips.rds")
#shapes <- readRDS("metrotransit-data/rds/shapes.rds")


# Get the shape for a particular route. This isn't perfect. Each route has a
# large number of different trips, and each trip can have a different shape.
# This function simply returns the most commonly-used shape across all trips for
# a particular route.
#get_route_shape <- function(route) {
#  routeid <- paste0(route, "-75")

# For this route, get all the shape_ids listed in trips, and a count of how
# many times each shape is used. We'll just pick the most commonly-used shape.
#  shape_counts <- trips %>%
#    filter(route_id == routeid) %>%
#    group_by(shape_id) %>%
#    summarise(n = n()) %>%
#    arrange(-n)

#shapeid <- shape_counts$shape_id[1]

# Get the coordinates for the shape_id
#shapes %>% filter(shape_id == shapeid)
#}
#referoutRatio <- read.csv("./data/referoutRatio.csv", fileEncoding="UTF-8")

referoutRatio <- read.csv("./data/referoutRatio.csv", sep=",",header = TRUE, fileEncoding="UTF-8")
referoutRatioData.m <- melt(referoutRatio)
referoutRatio <- fread("./data/referoutRatio.csv", header = TRUE, encoding="UTF-8")
ReferralPath <- fread("./data/referral.csv", header = TRUE, encoding="UTF-8")

hospitaldata <- fread("./data/geocode.csv", header = FALSE, encoding = "UTF-8")

names(hospitaldata) <- c("HospitalName", "HospitalLat", "HospitalLon")

twonPoly <- geojsonio::geojson_read("./data/twCounty.geojson", what="sp")

#print(twonPoly)
function(input, output, session) {
  
  
  
  output$referoutRatioTable = DT::renderDataTable({
    DT::datatable(referoutRatio)
  })
  output$ReferralPathTable = DT::renderDataTable({
    DT::datatable(ReferralPath)
  })
  output$hospitalsLocationTable = DT::renderDataTable({
    DT::datatable(hospitaldata)
  })
  output$referoutRatioHeatmap <- renderPlot({
    referoutRatioData.m <- ddply(referoutRatioData.m, .(variable), transform,rescale = rescale(value, to=c(0,10)))
    p <- ggplot(referoutRatioData.m, aes(variable, Name)) +
      geom_tile(aes(fill = rescale)) + labs(fill = "%") + theme(plot.title = element_text(lineheight=.8, face="bold")) +
      scale_fill_gradient(low = "white",high = "steelblue")
    plot(p)
    base_size <- 9
    p + theme_grey(base_size = base_size) + labs(title = 'Monthly Referral-out Ratio', x = "Month/Year",y = "Hospital Names", colour = "Cylinders") + scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      theme(legend.position = "bottom", axis.ticks = element_blank(), axis.text.x = element_text(size = base_size*0.8, angle = 320, hjust = 0, colour = "grey50",family = "BiauKai"))
  })
  
  output$hospitalNamesSelect <- renderUI({
    
    hospitalNames <- sort(unique(c(ReferralPath$H1,ReferralPath$H2,ReferralPath$H3)))
    names(hospitalNames) <- hospitalNames
    
    hospitalNames <- c("All", hospitalNames)
    selectInput("hospitalName", "Hospital", choices = hospitalNames, selected = hospitalNames[0])
  })
  
  
  referralPathData <- reactive({
    
    if (is.null(input$hospitalName))
      return()
    if(input$animation == TRUE){
      print(paste0(strsplit(toString(input$timeSlider), '-')[[1]][1],'/',strsplit(toString(input$timeSlider), '-')[[1]][2]))
    
      ReferralPath2 <- filter(ReferralPath, month == paste0(strsplit(toString(input$timeSlider), '-')[[1]][1],'-',strsplit(toString(input$timeSlider), '-')[[1]][2]))
      if (input$hospitalName == 'All')
        return(ReferralPath2)
      filter(ReferralPath2, H1 == input$hospitalName | H2 == input$hospitalName | H3 == input$hospitalName)
    }
    else{
      req(input$date)
      validate(need(!is.na(input$date[1]) & !is.na(input$date[2]), "Error: Please provide both a start and an end date."))
      validate(need(input$date[1] < input$date[2], "Error: Start date should be earlier than end date."))
      ReferralPath3<-filter(ReferralPath, as.POSIXct(paste0(month, '-01')) > as.POSIXct(input$date[1]) & as.POSIXct(paste0(month, '-01')) < as.POSIXct(input$date[2]))
      if (input$hospitalName == 'All')
        return(ReferralPath3)
      filter(ReferralPath3, H1 == input$hospitalName | H2 == input$hospitalName | H3 == input$hospitalName)
    }
    
    
  })
  
  allhospitalLocations <- reactive({
    input$refresh
  })
  
  output$numDuringDaysTable <- renderUI({
    PathData <- referralPathData()
    
    # Create a Bootstrap-styled table
    tags$table(class = "table",
               tags$thead(tags$tr(
                 tags$th("During Days"),
                 tags$th("Number of Referral")
               )),
               tags$tbody(
                 tags$tr(
                   tags$td("1 Day"),
                   tags$td(nrow(PathData[PathData$during == "1",]))
                 ),
                 tags$tr(
                   tags$td("3 Days"),
                   tags$td(nrow(PathData[PathData$during == "3",]))
                 ),
                 tags$tr(
                   tags$td("5 Days"),
                   tags$td(nrow(PathData[PathData$during == "5",]))
                 ),
                 tags$tr(
                   tags$td("7 Days"),
                   tags$td(nrow(PathData[PathData$during == "7",]))
                 ),
                 tags$tr(class = "active",
                         tags$td("Total"),
                         tags$td(nrow(PathData))
                 )
               )
    )
  })
  
  lastZoomButtonValue <- NULL
  output$referralmap <- renderLeaflet({
    locations <- hospitaldata
    if (length(locations) == 0)
      return(NULL)
    
    icons <- awesomeIcons(
      icon = 'hospital-o',
      iconColor = 'white',
      library = 'fa',
      markerColor = 'red'
    )
    
    map <- leaflet(locations) %>%
      addProviderTiles("Stamen.TonerLite") %>%
      ##http://leaflet-extras.github.io/leaflet-providers/preview/
      #addTiles('http://{s}.tile.thunderforest.com/transport/{z}/{x}/{y}.png') %>%
      #addTiles(
      #urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png"
      #) %>%
      #addTiles('http://{s}.tile.stamen.com/watercolor/{z}/{x}/{y}.png')%>%
      #addTiles('https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}')%>%
      #addTiles()%>%
      addPolygons(data=twonPoly, weight = 1, color = "#444444", fill = FALSE)%>%
      addMiniMap(tiles = "Stamen.TonerLite", toggleDisplay = TRUE,position = "bottomleft")%>%
      addAwesomeMarkers(
        ~HospitalLon,
        ~HospitalLat,
        icon= icons,
        label = ~HospitalName,
        clusterOptions = markerClusterOptions(iconCreateFunction=JS(
          "function (cluster) {    
          var childCount = cluster.getChildCount(); 
          var c = ' marker-cluster-';  
          if (childCount < 10) {  
          c += 'large';  
          } else if (childCount < 50) {  
          c += 'medium';  
          } else { 
          c += 'small';  
          }    
          return new L.DivIcon({ html: '<div><span>' + childCount + '</span></div>',
          className: 'marker-cluster' + c, iconSize: new L.Point(40, 40) });
          
  }")))
    
    data <- referralPathData()
    data <- data.frame(data)
    if (length(input$duringDays) == 0)
      return(NULL)
    duringData <- filter(data, during %in% as.numeric(input$duringDays))
    duringData["count"] = rep(1, dim(duringData)[1])
    duringData <- aggregate(count ~ H1 + H2 + H3 + H1lat+H1lng+H2lat+H2lng+H3lat+H3lng , duringData, function(x) length(x))
    
    bins <- c(1, 3, 5, 7, 9, Inf)
    pal <- colorBin(c("#8fc6f7", "#022e56"), domain = duringData[length(colnames(duringData))], bins = bins)
    duringData <- duringData[order(duringData$count), ]
    duringData["count_rescale"]<- (duringData$count - min(duringData$count))/(max(duringData$count)-min(duringData$count)) * 3 + 1
    for(i in 1:nrow(duringData)){
      geo_lines1 <- gcIntermediate(
        c(duringData$H1lng[i], duringData$H1lat[i]),
        c(duringData$H2lng[i], duringData$H2lat[i]),
        sp = FALSE,
        addStartEnd = FALSE,
        n = 100
      )
      geo_lines2 <- gcIntermediate(
        c(duringData$H2lng[i], duringData$H2lat[i]),
        c(duringData$H3lng[i], duringData$H3lat[i]),
        sp = FALSE,
        addStartEnd = TRUE,
        n = 100
      )
      pathpop <- paste("<style> div.leaflet-popup-content {max-width:100% !important;}</style>",
                       "<b><a>",duringData$H1[i],"->",duringData$H2[i],"->",duringData$H3[i],"</a></b></br>
                       Count:",duringData$count[i]
      )
      geo_lines <- rbind(geo_lines1, geo_lines2)
      map <-  addPolylines(map, 
                           data = geo_lines,
                           color = pal(duringData$count[i]),
                           fillColor = pal(duringData$count[i]),
                           popup = pathpop,
                           weight = duringData$count_rescale[i]+1,
                           opacity = 0.5,
                           highlightOptions = highlightOptions(color = "black",opacity = 1, weight = duringData$count_rescale[i], bringToFront = TRUE)
      )
      
    }
    map <- addLegend(map, pal = pal, values = duringData$N, opacity = 0.7, title = "Count",
                     position = "bottomleft")
    
    rezoom <- "first"
    if (!identical(lastZoomButtonValue, input$zoomButton)) {
      
      lastZoomButtonValue <<- input$zoomButton
      rezoom <- "always"
    }
    
    map <- map %>% mapOptions(zoomToLimits = rezoom)
    
    map
})
  }