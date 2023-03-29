library(shiny)
library(shinydashboard)
library(echarts4r)
library(tidyverse)
library(DT)
library(dplyr)
library(tidyr)
library(readxl)
library(lubridate) #fechas

source("codificacion.R")
source("data/EstructurarDatos.R")
source("plots.R")

# -*- coding: UTF-8 -*-
# Define server logic required to draw a histogram
server = function(input, output, session) {
  
  
  output$tableData <- shiny::renderDataTable({
    datos %>% 
      select(-URL_CTI)
  }, options = list(searching = TRUE,
                    pageLength = 9,
                    lengthChange = FALSE,
                    ordering = TRUE,
                    paging = TRUE
  )
  , escape = FALSE)
  
  
  
  output$barra_niv_edad <- renderEcharts4r({
    barra_nivel_edad
  })
  
  output$barra_edad <- renderEcharts4r({
    barra_edad
  })
  
  output$barra_niv_sex <- renderEcharts4r({
    barra_nivel_Sexo
  })
  
  output$circular_sex <- renderEcharts4r({
    circular_sexo
  })
  
  
  
  #codigo_buscado <- eventReactive(input$boton, {
  #  input$buscador
  #})
  
  #inv_nombre <- datos %>% 
  #  filter(codigo_renacyt == codigo_buscado()) %>% 
  #  select(Investigador) %>% as.character()
  
  #output$investigador <- renderText({
  #  codigo_buscado()
  #})
  
  observeEvent(input$boton,{
    codigo_buscado = input$buscador
    
    datafiltered = datos %>% 
      filter(codigo_renacyt == codigo_buscado)
    
    output$investigador <- renderText({
      datafiltered$Investigador
    })
    
    output$genero <- renderText({
      as.character(datafiltered$Genero)
    })
    
    output$grupo <- renderText({
      datafiltered$grupo
    })
    
    output$nivel <- renderText({
      as.character(datafiltered$nivel)
    })
    
    output$fechai <- renderText({
      as.character(datafiltered$fecha_de_inicio_de_vigencia)
    })
    
    output$fechaf <- renderText({
      ifelse(is.na(datafiltered$fecha_fin_de_vigencia),"A la actualidad",as.character(datafiltered$fecha_fin_de_vigencia))
    })
    
    output$edad <- renderText({
      as.character(datafiltered$rangoEdad)
    })
    
    output$reglamento <- renderText({
      datafiltered$reglamento
    })
    
    output$url <- renderUI({
      a(href = datafiltered$URL_CTI, target="_blank", "Mas información - CTI")
    })
    
  })
  
  
}




