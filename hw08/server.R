
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(tidyverse)
library(DT)
library(leaflet)
library(ggmap)


shinyServer(function(input, output) {
	
	bcl_data <- read_csv('bcl-data.csv')
	
	#using uiOutput() for give users options of country
	output$country <- renderUI({
			selectInput("country","Country",
									sort(unique(bcl_data$Country)),
									selected = "CANADA",
									multiple = TRUE)
	})
	
	# filtering based on the input
	filtered_bcl<- reactive({
		bcl_data %>%
			filter(Price >= input$priceIn[1] &
						 	Price <= input$priceIn[2] &
						 	Type %in% input$typeIn &
						 	Country %in% input$country
						 )
			
	})
	
	# Sidebar liquor store info
	# get data using ggmap::geocode 
	location <- geocode("UBC liquor store", output = "latlon")
	
	# make map using leaflet
	output$map <- renderLeaflet({
		leaflet() %>%
			addTiles() %>%  
			addMarkers(lng=location$lon, lat=location$lat, popup = "UBC liquor store")
	})
	
	# make two histograms
	output$Hist_AlcCont <- renderPlot({
		filtered_bcl() %>%
			ggplot() +
			aes(x = Alcohol_Content) + geom_histogram(aes(fill=Type))
	})
	output$Hist_Price <- renderPlot({
		filtered_bcl() %>%
			ggplot() +
			aes(x = Price) + geom_histogram(aes(fill=Type))
	})
	
	# make table
	output$table <- DT::renderDataTable({
		filtered_bcl() 
	})
	
})
