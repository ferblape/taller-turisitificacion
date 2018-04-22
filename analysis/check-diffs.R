require(tidyverse)
library(ggplot2)
library(plotly)

setwd('~/proyectos/exploratory-data-analysis/turistificacion/')

f1 <- "~/proyectos/exploratory-data-analysis/turistificacion/data/raw/actividades-comerciales/20150201.csv"
f2 <- "~/proyectos/exploratory-data-analysis/turistificacion/data/raw/actividades-comerciales/20180301.csv"

distritos <- c("ARGANZUELA", "USERA", "CENTRO")

df1 <- read_delim(f1, ';') %>% 
  select(desc_situacion_local,id_local,desc_distrito_local,desc_barrio_local,clase_vial_acceso,desc_vial_acceso,rotulo,desc_seccion, desc_division, desc_epigrafe) %>% 
  filter(!is.na(desc_seccion) & desc_situacion_local == "Abierto") %>%
  mutate(desc_distrito_local = trim(desc_distrito_local)) %>% 
  filter(desc_distrito_local %in% distritos)

df2 <- read_delim(f2, ';') %>% 
  select(desc_situacion_local,id_local,desc_distrito_local,desc_barrio_local,clase_vial_acceso,desc_vial_acceso,rotulo,desc_seccion, desc_division, desc_epigrafe) %>% 
  filter(!is.na(desc_seccion) & desc_situacion_local == "Abierto") %>%
  mutate(desc_distrito_local = trim(desc_distrito_local)) %>% 
  filter(desc_distrito_local %in% distritos)

df1_aggr <- df1 %>% 
  group_by(desc_distrito_local, desc_epigrafe) %>% 
  summarize(count_2015 = n())
 
df2_aggr <- df2 %>% 
  group_by(desc_distrito_local, desc_epigrafe) %>% 
  summarize(count_2018 = n()) 

df_diff <- df1_aggr %>% 
  inner_join(df2_aggr, by=c("desc_distrito_local" = "desc_distrito_local", "desc_epigrafe" = "desc_epigrafe")) %>% 
  mutate(diff_perc = ((count_2018 - count_2015) / count_2015) * 100) %>% 
  mutate(diff = (count_2018 - count_2015))

write_csv(df_diff, "diff.csv")

# barrio, distrito, actividad, diff

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
