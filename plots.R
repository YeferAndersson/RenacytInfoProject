#graficos

#install.packages("echarts4r")

library(echarts4r)
library(tidyverse)



glimpse(datos)

#diagrama circular con e_chart
circular_sexo <- datos %>% 
  group_by(Genero) %>% 
  summarise(n = n()) %>% 
  e_chart(Genero) %>% 
  e_pie(n,legend = F, name = "Genero",
        radius = c("40%", "70%"),
        itemStyle = list(
          borderRadius = 10,
          borderColor = "#333",
          borderWidth = 3
        )) %>% 
  e_color(c("#EF767A","#66C3FF")) %>% 
  e_tooltip() %>% 
  e_theme("dark-fresh-cut")


#BAR PLOT

#Opcion1
datos %>% 
  group_by(nivel,Genero) %>% 
  summarise(n = n()) %>% 
  spread(Genero, n) %>% # dividir la columna genero en 2 columnas (M,F)
  #cambiando el valor NA por "nivel fantante"
  mutate(nivel = as.character(nivel)) %>% 
  mutate(nivel = ifelse(is.na(nivel),"nivel faltante",nivel)) %>% 
  mutate(nivel = as.factor(nivel)) %>%
  #desagrupando para usar el slice y ordenarlo a mi manera
  ungroup() %>% 
  slice(c(4,1,2,3,5,6,7,8,9)) %>% # ´para ordenar la posicion a mi gusto
  e_chart(nivel) %>% 
  e_bar(Femenino, stack = "grp") %>% 
  e_bar(Masculino, stack = "grp") %>% 
  e_color(c("pink","skyblue")) %>% 
  #e_bar(n, legend = FALSE, name = "nivel") %>% 
  #e_labels(position = "right") %>% 
  e_flip_coords() %>% 
  e_y_axis(splitLine = list(show = FALSE)) %>% 
  e_tooltip(
    trigger = "axis",
    axisPointer = list(
      type = "shadow"
    )
  ) %>% 
  e_theme("westeros")


#opcion2 - la mejor
barra_nivel_Sexo <- datos %>% 
  group_by(nivel,Genero) %>% 
  summarise(n = n()) %>% 
  mutate(nivel = as.character(nivel)) %>% 
  mutate(nivel = ifelse(is.na(nivel),"nivel faltante",nivel)) %>% 
  mutate(nivel = as.factor(nivel)) %>%
  group_by(Genero) %>% #agrupando para implementarlo en la funcion e_chart
  slice(c(4,1,2,3,5,6,7,8,9)) %>%
  e_chart(nivel, stack = "grp") %>% 
  e_bar(n, legend = FALSE) %>% 
  e_color(c("#EF767A","#66C3FF")) %>% 
  #e_color(c("#EF767A","#679BC5")) %>% 
  #e_labels(position = "right") %>% 
  e_flip_coords() %>% 
  e_y_axis(splitLine = list(show = FALSE)) %>% 
  e_tooltip(
    trigger = "axis",
    axisPointer = list(
      type = "shadow"
    )
  ) %>% 
  e_theme("dark-fresh-cut")



#por edad
barra_nivel_edad <- datos %>% 
  group_by(nivel,rangoEdad) %>% 
  summarise(n = n()) %>% 
  mutate(nivel = as.character(nivel)) %>% 
  mutate(nivel = ifelse(is.na(nivel),"nivel faltante",nivel)) %>% 
  mutate(nivel = as.factor(nivel)) %>%
  ungroup() %>%#agrupando para implementarlo en la funcion e_chart
  slice(c(25:30,1:24,31:65)) %>%
  group_by(rangoEdad) %>% 
  e_chart(nivel, stack = "grp") %>% 
  e_bar(n, legend = F) %>% 
  e_x_axis(axisLabel = list(rotate = 45)) %>% 
  #e_labels(position = "right") %>% 
  #e_flip_coords() %>% 
  e_y_axis(splitLine = list(show = FALSE)) %>% 
  e_tooltip(
    trigger = "axis",
    axisPointer = list(
      type = "shadow"
    )
  )%>% 
  e_theme("dark-blue") 
  


barra_edad <- datos %>% 
  group_by(rangoEdad) %>% 
  summarise(cantidad = n()) %>% 
  e_chart(rangoEdad) %>% 
  e_bar(cantidad, legend = F) %>% 
  e_color(c("#66C3FF")) %>% 
  e_flip_coords() %>% 
  e_y_axis(splitLine = list(show = FALSE)) %>% 
  e_tooltip(
    trigger = "axis",
    axisPointer = list(
      type = "shadow"
    )
  ) %>% 
  e_theme("dark-fresh-cut")

