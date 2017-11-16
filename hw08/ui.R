
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(tidyverse)
library(shinythemes)
library(DT)
library(leaflet)



shinyUI(fluidPage(theme = shinytheme("united"),
	
	# Application title
	titlePanel("BC Liquor Price Shiny App"),
	absolutePanel("Made by Yeonuk Kim (Nov. 21. 2017)",top = 5, right = 10),
	
	
	sidebarLayout(
		# Sidebar with a slider input
		sidebarPanel(
			           wellPanel(" This app will help you find the right drink for tonight! 
			           					Just use the filters below."),
			           img(src = "image.jpg", width = "100%"),
								 wellPanel(sliderInput("priceIn","Price of booze",
								 						min = 0, max = 300, value = c(10,20),
								 						pre = "CAD")),
								 wellPanel(uiOutput("country")),
								 
								 wellPanel(checkboxGroupInput("typeIn", "What kind of booze?",
								 						 choices = c("BEER", "WINE", "SPIRITS"),
								 						 selected = c("BEER", "WINE", "SPIRITS"))),
								 # Sidebar liquor store map
								 wellPanel(leafletOutput("map"))
								 ),
		
		
		# Show a plot of the generated distribution and table
		mainPanel(
			tabsetPanel(
				tabPanel("Histogram_by_Alcohol_content", plotOutput("Hist_AlcCont")),
				tabPanel("Histogram_by_Price", plotOutput("Hist_Price"))
			),
			DT::dataTableOutput("table")
		)
	)
)
)

