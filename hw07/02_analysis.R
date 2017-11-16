rm(list=ls())

library(tidyverse)


# Read the output of the second script
data <- read_csv('raw_data/merged_data.csv')

# NaN to Na
data[is.na(data)] <- NA



# Make figures
colnames(data) <- c('time', 'ch4f', 'airT205','airT038','soilT005','soilT010','soilT050',
                    'waterT010','waterT030','ORP010','ORP030','WTH','SM')
col <- colnames(data)




for (i in c(3:13)){
  
  # Frequency...
  df <- data

  use <- df %>% select(col[i])
  minimum <- min(use, na.rm=TRUE)
  maximum <- max(use, na.rm=TRUE)
  bin <- (maximum - minimum)/14
  
  df[,i] <- cut(data.matrix(use), breaks = seq(minimum,maximum,bin))
  

  result <- df %>% group_by(eval(parse(text=col[i]))) %>%
    dplyr::summarise(ch4F_freq = n_distinct(ch4f), freq = n())
  colnames(result) <- c('x', 'ch4F_freq', 'freq')
  
  
  result1 <- result %>% mutate(percent = round(100*ch4F_freq/freq))
  result2 <- gather(result1,val="frequency",key="variable",-c(1,4))
  
  # latest data 
  use <- tail(df[,i],1)
  now <- tail(df[,1],1)

  
  
  # Figure
  p <- result2 %>% ggplot(aes(x= x,y = frequency, fill = variable)) + 
    geom_bar(stat="identity", position=position_dodge()) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) + xlab(col[i]) +
    geom_text(aes(label= ifelse(variable == 'ch4F_freq', paste(percent,"%"),''))) +
    geom_text(aes(label= ifelse(variable == 'freq' & as.numeric(x) == as.numeric(use), 
                                paste('Now!',now$time,sep="\n"),'')),
              fontface = "bold", colour='red', angle = 90)

  ggsave(paste0("figure/",col[i],".png"),plot=p) 
  
}


