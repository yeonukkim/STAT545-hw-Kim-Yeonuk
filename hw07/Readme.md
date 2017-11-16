# HW 07

Automating Data-analysis Pipelines

## Brief reflection

### About data which I used.
Data which I used is real-time micrometeorological measurement data from Burns Bog. (This is not processed data, but raw data.)
This flux tower system has been getting energy from solar panels, but rainy season usually causing power limitation. 
Particularly, the instrument for methane flux measurement consumes large energy, so decision making for turning on/off the instrument is important. 
Personally, I used this homework to help this decision making. However, I did not fully accomplish my intention, and consequently the results are not well organized. I am so sorry for that. But, I will improve the results soon and I will use the *automating data-analysis pipelines* for my future work. 

![figure](https://github.com/yeonukkim/STAT545-hw-Kim-Yeonuk/blob/master/hw07/flowchart.png)

1. Download methane flux and other environmental measurement data.
- The first R script downloaded methane flux (BBFMA.csv) and other variables which can affect methane flux (e.g. soil temperature).
- 7 separate files were downloaded from web.
- In order to make the *hw07* folder organized, the downloaded files were saved at a folder (*raw_data*).

2. Merge downloaded data.
- The second R script read the downloaded 7 files and merged them into one file (merged_data.csv).
- The output of the second R script was also saved at the folder *raw_data*.

3. Make figures.
- Comparing availabilities of methane flux and other environmental data in terms of degree of such environmental data. 
- Checking position of the latest data.
