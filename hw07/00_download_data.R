
# Download the raw data
library(downloader)
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBXTA.csv", 
         destfile = "hw07/system_temp.csv")
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBBCR.csv", 
         destfile = "hw07/current.csv")
download(url = "http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBBVA.csv", 
         destfile = "hw07/voltage.csv")



