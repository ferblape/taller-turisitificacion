require(tidyverse)

setwd('~/proyectos/exploratory-data-analysis/turistificacion/')

## Cleans actividades-comerciales data
#  - Input data/raw/actividades-comerciales/*.csv
#  - Output data/output/actividades-comerciales/
#############

classify <- function(x) {
  case_when(
         x == 'TALLER DE REPARACION DE AUTOMOVILES ESPECIALIZADO EN MECANICA Y ELECTRICIDAD' ~ 'Mecanico',
         x == 'COMERCIO AL POR MENOR DE PRENDAS DE VESTIR EN ESTABLECIMIENTOS ESPECIALIZADOS' ~ 'Tienda de ropa',
         x == 'ARREGLO DE ROPA' ~ 'Arreglo de ropa',
         x == 'CENTRO DE PRIMARIA, SECUNDARIA, BACHILLERATO Y/O FP PRIVADO' ~ "Escuela",
         x == 'CENTRO DE INFANTIL Y PRIMARIA PUBLICO' ~ "Escuela",
         x == 'ESCUELA INFANTIL PRIVADA' ~ "Escuela",
         x == 'IDIOMAS' ~ "Idiomas",
         x == 'AUTOESCUELA' ~ "Autoescuela",
         x == 'FARMACIA' ~ "Farmacia",
         x == 'COMERCIO AL POR MENOR DE CARNICERIA-SALCHICHERIA' ~ 'Carniceria',
         x == 'COMERCIO AL POR MENOR DE CARNICERIA' ~ 'Carniceria',
         x == 'COMERCIO AL POR MENOR DE CASQUERIA' ~ 'Carniceria',
         x == 'COMERCIO AL POR MENOR DE CARNICERIA-CHARCUTERIA' ~ 'Carniceria',
         x == 'COMERCIO AL POR MENOR DE PESCADOS Y MARISCOS CON OBRADOR (INCLUYE COCCION)' ~ 'Pescaderia',
         x == 'COMERCIO AL POR MENOR DE PESCADOS Y MARISCOS SIN OBRADOR' ~ 'Pescaderia',
         TRUE ~ 'OTRO'
  )
}

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

distritos <- c("ARGANZUELA", "USERA", "CENTRO")

files <- list.files(path="~/proyectos/exploratory-data-analysis/turistificacion/data/raw/actividades-comerciales", pattern="*.csv", full.names=T, recursive=FALSE)

lapply(files, function(x) {
  print(x)
  y <- strsplit(x, "/")
  file_name <- y[[1]][[length(y[[1]])]]
  
  df <- read_delim(x, ';') %>% 
    select(desc_situacion_local,id_local,desc_distrito_local,desc_barrio_local,clase_vial_acceso,desc_vial_acceso,rotulo,desc_seccion, desc_division, desc_epigrafe) %>% 
    filter(!is.na(desc_seccion) & desc_situacion_local == "Abierto") %>%
    mutate(desc_distrito_local = trim(desc_distrito_local)) %>% 
    filter(desc_distrito_local %in% distritos) %>% 
    mutate(categoria = classify(desc_epigrafe)) %>% 
    filter(categoria != 'OTRO')
  
  View(df)
  
  write_csv(df, paste0("~/proyectos/exploratory-data-analysis/turistificacion/data/output/actividades-comerciales/", file_name))
})
