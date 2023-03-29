#librerias
library(dplyr)
library(tidyr)
library(readxl)
library(lubridate) #fechas

#importar y limpieza de datos
datos <- read_xlsx("data/RENACYT 01012023.xlsx",col_types = rep("text",10))

datos <- as_tibble(datos) #datos tibble para facilitar lectura
head(datos) 
tail(datos)
glimpse(datos)


datos <- datos %>% 
  rename(rangoEdad = `Rango de Edad`)

datos <- datos %>% 
  rename(URL_CTI = `URL CTI Vitae`)

#tipos de variables
datos$Genero <- as.factor(datos$Genero)
datos$nivel <- as.factor(datos$nivel)
datos$fecha_de_inicio_de_vigencia <- as.Date(datos$fecha_de_inicio_de_vigencia)
datos$fecha_fin_de_vigencia <- as.Date(datos$fecha_fin_de_vigencia)
datos$rangoEdad <- as.factor(datos$rangoEdad)

#cambiando los niveles de la variable factor 'rangoEdad'
levels(datos$rangoEdad) <- gsub("Entre ([0-9]+) a ([0-9]+) años", "\\1 a \\2", levels(datos$rangoEdad))

nrow(datos)

levels(datos$rangoEdad)

glimpse(datos)

