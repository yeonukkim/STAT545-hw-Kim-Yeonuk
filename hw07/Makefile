## one Makefile to make them all

all: ./figure/*.png

clean:
	rm -f ./figure/*.png
	rm -f ./raw_data/*.csv
	

#BBFMA.csv:
#	curl -L http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBFMA.csv >BBFMA.csv
#	curl -L http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBDTA.csv >BBDTA.csv
#	curl -L http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBSTA.csv >BBSTA.csv
#	curl -L http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBWTA.csv >BBWTA.csv
#	curl -L http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBORP.csv >BBORP.csv
#	curl -L http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBWPT.csv >BBWPT.csv
#	curl -L http://ibis.geog.ubc.ca/~epicc/webdata/resources/csv/BBSMA.csv >BBSMA.csv


./raw_data/BBFMA.csv:
	Rscript 00_download_data.R

./raw_data/merged_data.csv: 01_pre_analysis.R ./raw_data/BBFMA.csv
	Rscript $<

./figure/*.png: 02_analysis.R ./raw_data/merged_data.csv
	Rscript $<
	



	
