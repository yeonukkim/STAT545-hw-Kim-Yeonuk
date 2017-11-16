rm(list=ls())

# Download the raw data
library(downloader)

# Methane flux
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBFMA.csv", 
         destfile = "hw07/raw_data/BBFMA.csv")

# Air temperature
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBDTA.csv", 
         destfile = "hw07/raw_data/BBDTA.csv")

# Soil temperature
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBSTA.csv", 
         destfile = "hw07/raw_data/BBSTA.csv")

# Water temperature
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBWTA.csv", 
         destfile = "hw07/raw_data/BBWTA.csv")

# Oxidation Reduction Potential
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBORP.csv", 
         destfile = "hw07/raw_data/BBORP.csv")

# Water table height
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBWPT.csv", 
         destfile = "hw07/raw_data/BBWPT.csv")

# Volumetric soil water content
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBSMA.csv", 
         destfile = "hw07/raw_data/BBSMA.csv")
