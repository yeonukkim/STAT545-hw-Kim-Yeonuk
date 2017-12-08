HW10 Data from the Web
================
Yeonuk
December 7, 2017

[link to the hw10](https://github.com/yeonukkim/STAT545-hw-Kim-Yeonuk/edit/master/hw10/HW10.md)

## Reflection
- I worked on *Scrape the web* among the three options.
- The final goal is getting conference informatino table from *Conference Alert*.
- Most difficult part is using *html_nodes*

*html_nodes* can be used when the data I need under a class. But, data what I want to get is under *`<span itemprop="####" id="####">`*.
 I tried to understand the html structure, and found the answer. (i.e. *html_nodes("span#eventNameHeader")* )
  
