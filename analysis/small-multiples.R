require(tidyverse)
library(ggplot2)
library(plotly)

setwd('~/proyectos/exploratory-data-analysis/turistificacion/')

files <- list.files(path="~/proyectos/exploratory-data-analysis/turistificacion/data/output/actividades-comerciales", pattern="*.csv", full.names=T, recursive=FALSE)

df <- data.frame()
for(x in files){
  print(x)
  y <- strsplit(x, "/")
  file_name <- y[[1]][[length(y[[1]])]]
  date <- as.Date(file_name, "%Y%m%d") 
  
  df_sum <- read_delim(x, ',') %>% 
    group_by(desc_distrito_local, desc_barrio_local, categoria) %>% 
    summarize(count = n()) %>% 
    mutate(date = date)
  
  if (nrow(df) == 0) {
    df <- df_sum
  } else {
    df <- rbind(df, df_sum)
  }
}
View(df)


ggplot(df, aes(x=date, y=count, group=categoria, color=categoria)) +
  geom_line()+
  facet_wrap(~ desc_barrio_local)+
  labs(title = "Evolucion comercio Arganzuela, Usera y Centro")+
  theme(axis.ticks = element_blank(), axis.text.x = element_blank(), legend.position = "bottom")  + 
  labs(x = "Fecha (2015 - 2018)", y = "Total comercios") 
