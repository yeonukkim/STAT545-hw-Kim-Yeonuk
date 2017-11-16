rm(list=ls())

library(tidyverse)


# Read the output of the first script

ch4flux <- read_csv('raw_data/BBFMA.csv') # Methane flux
airtemp <- read_csv('raw_data/BBDTA.csv') # Air temperature
soiltemp <- read_csv('raw_data/BBSTA.csv') # Soil temperature
watertemp <- read_csv('raw_data/BBWTA.csv') # Water temperature
ORP <- read_csv('raw_data/BBORP.csv') # Oxidation Reduction Potential
WTH <- read_csv('raw_data/BBWPT.csv') # Water table height
SM <- read_csv('raw_data/BBSMA.csv') # # Volumetric soil water content


# merge all data by using Join

merged_data <- left_join(ch4flux,airtemp,by='Time (PST)')
merged_data <- left_join(merged_data,soiltemp,by='Time (PST)')
merged_data <- left_join(merged_data,watertemp,by='Time (PST)')
merged_data <- left_join(merged_data,ORP,by='Time (PST)')
merged_data <- left_join(merged_data,WTH,by='Time (PST)')
merged_data <- left_join(merged_data,SM,by='Time (PST)')


# Na to NaN
merged_data[is.na(merged_data)] <- NaN


# Save
write_csv(merged_data, path = 'C:/Users/Yeonuk/Documents/R/STAT545-hw-Kim-Yeonuk/hw07/raw_data/merged_data.csv')