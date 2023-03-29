library(shiny)
library(shinydashboard)
library(dashboardthemes)
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
ui = dashboardPage(
  ##############
  ### Header ###
  ##############
  dashboardHeader(title = "RenacytInfo",
                  titleWidth = "10vw" ),
  
  ####################
  ### SIDEBAR MENU ###
  ####################
  dashboardSidebar(
    width = "10vw",
    sidebarMenu(id = "tabs",
                menuItem("Introducción", tabName = "intro",icon = icon("file")),
                menuItem("General", tabName = "general"),
                menuItem("Individual", tabName = "individual"))
  ),
  
  ############
  ### Body ###
  ############
  dashboardBody(
    shinyDashboardThemes(
      theme = "grey_dark"
    ),
    fluidRow(
      tabItems(
        
        tabItem(tabName = "intro",
                column(style="text-align: justify;",width=10, offset = 1,
                       h3("Registro Nacional de Investigadores Renacyt", align="middle"),
                       p("Bienvenidos al Registro Nacional de Investigadores Renacyt, el cual es el Registro Nacional Científico, Tecnológico y de Innovación Tecnológica de las personas naturales que realizan actividades de ciencia, tecnología e innovación en el Perú. Este registro también incluye a los peruanos que realizan estas actividades en el extranjero y a los extranjeros que no residen en el Perú, pero tienen un compromiso con una entidad peruana para desarrollar estas acciones en el país. A través de esta plataforma, se busca promover la investigación y el desarrollo tecnológico en el Perú y fomentar la colaboración científica a nivel nacional e internacional."),
                       p("En esta aplicación Shiny R, podrás encontrar estadísticas del Renacyt, así como información individual de cada uno de los investigadores registrados. Todos los datos son de acceso público y están disponibles a través de la plataforma nacional de datos abiertos del Perú."),
                       p("La información que se muestra de cada investigador incluye su código Renacyt, nombre completo, género, URL_CTI, grupo de investigación, nivel, fecha de inicio y fin de vigencia, rango de edad y el reglamento al que pertenece."),
                       p("Es importante destacar que todos los datos presentados en esta aplicación están actualizados hasta el 17 de enero de 2023. Esperamos que esta herramienta sea útil para investigadores, estudiantes y cualquier persona interesada en el avance de la ciencia, tecnología e innovación en el Perú."),
                       br(),
                       
                       box(width = 12,
                           shiny::dataTableOutput("tableData"),style = "height:700px; overflow-y: scroll;")
                       )
                       
                       
                
                ),
        
        tabItem(tabName = "general",
                
                column(width = 8,
                       infoBox("Cantidad de investigadores", as.character(nrow(datos)), "Hasta el 17-01-2023",
                          color = "light-blue", width = 7)),
                
                column(width = 8,
                       box(width = 12,
                           title = "Nivel de los investigadores y edad",
                           status = "primary",
                           solidHeader = T,
                           echarts4rOutput("barra_niv_edad",height = "40vh")
                           ),
                       box(width = 12,
                           title = "Edad de los investigadores",
                           status = "primary",
                           solidHeader = T,
                           echarts4rOutput("barra_edad",height = "40vh")
                       )
                       ),
                column(width = 4,
                       box(width = 12,
                           title = "Sexo de los investigadores",
                           status = "primary",
                           solidHeader = T,
                           echarts4rOutput("circular_sex",height = "40vh")
                       ),
                       box(width = 12,
                           title = "Nivel de los investigadores y sexo",
                           status = "primary",
                           solidHeader = T,
                           echarts4rOutput("barra_niv_sex",height = "40vh")
                       )
                   
                )
                ),
        
        tabItem(tabName = "individual",
                column(width = 4,
                       box(width = 12,
                           textInput("buscador", "Codigo del investigador:", width = "100%",placeholder = "P0316823"),
                           actionButton("boton", "Buscar"))),
                column(width = 8,
                       box(width=6,
                           title = "Investigador",
                           status = "primary",
                           solidHeader = T,
                           textOutput("investigador")),
                       
                       box(width=6,
                           title = "Nivel",
                           status = "primary",
                           solidHeader = T,
                           textOutput("nivel")),
                       
                       box(width=6,
                           title = "Genero",
                           status = "info",
                           solidHeader = T,
                           textOutput("genero")),
                       
                       box(width=6,
                           title = "Edad",
                           status = "info",
                           solidHeader = T,
                           textOutput("edad")),
                       
                       box(width=6,
                           title = "Grupo",
                           status = "primary",
                           solidHeader = T,
                           textOutput("grupo")),
                       
                       box(width=6,
                           title = "Reglamento",
                           status = "primary",
                           solidHeader = T,
                           textOutput("reglamento")),

                       box(width=6,
                           title = "Fecha Inicio",
                           status = "info",
                           solidHeader = T,
                           textOutput("fechai")),
                       
                       box(width=6,
                           title = "Fecha Fin",
                           status = "info",
                           solidHeader = T,
                           textOutput("fechaf")),
                       
                       box(
                         solidHeader = TRUE,
                         status = "primary",
                         width = 4,
                         htmlOutput("url")
                         
                       )
                       
                       )
                
                )
        
        
      )
    )
  )
)

