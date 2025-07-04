# ANÁLISIS DE DATOS
# Daniel Sánchez
# El Quantificador

# ---- LIBRERIAS ----

# Este código es para instalar las librerías que necesite el usuario para compilar el código

if(!require(survey)) install.packages("survey", repos = "http://cran.us.r-project.org")
if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(patchwork)) install.packages("patchwork", repos = "http://cran.us.r-project.org")
if(!require(openxlsx)) install.packages("openxlsx", repos = "http://cran.us.r-project.org")
if(!require(haven)) install.packages("haven", repos = "http://cran.us.r-project.org")

# ---- DATOS ----

# Cargamos los datos de forma dinámica haciendo source al script de carga de datos

source('code/protestas_download.R')

# df <- read.csv('data/protests_data.csv') # Esta es la misma base de datos que está subida en nuestro drive. Un error de paquetes no me permite descargar.

# load('data/full_lapop_dataset.Rdata')

# Esta base de datos se construye a partir de los datos abiertos que LAPOP provee al público- si quieres observar como se ha construido la base,
# puedes entrar al script 'protestas_data_manipulation.R' y a mi repositorio hbc-v2.

# ---- FORMATOS ----

# Definimos algunos formatos para utilizar después

# Definimos colores en HEX para los gráficos

quant_blue<-'#09A4CC'
quant_grey<-'#5C7C94'
quant_orange<-'#F8754D'
quant_red<-'#F44D54'

# Creamos un theme para los gráficos de ggplot2

theme_article_ds<-
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text.y = element_blank(),
        plot.caption = element_text(hjust = 0, face = 'italic'),
        legend.background = element_blank())

# ---- SURVEY DESIGN ----

# Creamos el objeto de diseño muestral para utilizar en los cálculos

lapop_des<-svydesign(ids = ~ upm,
                     strata = ~ estratopri, 
                     weights = ~ weight1500, 
                     nest = TRUE,
                     na.action = 'na.exclude',
                     data = df)

# ---- ANÁLISIS ----

## 1. Participación en protestas

# Debemos construir una sola variable en la base de datos que denote 1 si es que se participó en protest, 0 de otra forma

# De 2010 a 2019 se tiene prot3

# De 2006 a 2008 se tiene dos preguntas diferentes. 2004 no tiene pregunta sobre participación en protesta

# En el script de manipulación, he unificado las variables prot1, prot2 y prot3 en una sola (prot3)

# Por ende, tabulamos esa variable a lo largo del tiempo 

prot_time<-
  svyby(~ protest,
        ~ year,
        design = lapop_des,
        svymean,
        na.rm = T,
        keep.names = F)

# Creamos una base de datos "tidy" para esto

prot_df<-
  prot_time %>%
  filter(protest > 0) %>% 
  as.data.frame()

# Gráfico 1: Participación en Protestas:

# Guardar en un objeto el caption largo:

caption_grafo1<-
  'Fuente: El Barómetro de las Américas por el Proyecto de Opinión Pública de América Latina (LAPOP), www.LapopSurveys.org. Las barras representan intervalos de confianza del 95% con errores ajustados por diseño muestral multietapa estratificado. Las líneas punteadas representan protestas de importancia en el país. Las encuestas fueron realizadas de enero a marzo de cada año, excepto la ronda 2016, realizada de noviembre 2016 a enero 2017. Las cifras representan el porcentaje de personas que han protestado en los últimos 12 meses sobre el total de personas en edad de votar (mayores a 16).'

# Ahora si nuestro gráfico

prot_part_graf<- 
  ggplot(prot_df, aes(x = year, y = protest))+
  geom_col(fill = quant_blue,
           color = 'black', 
           width = 0.7)+
  geom_vline(xintercept = 0.5, linetype = 'dotted', color = quant_red, size = 1.25)+
  geom_vline(xintercept = 3.45, linetype = 'dotted', color = quant_red, size = 1.25)+
  geom_vline(xintercept = 5.55, linetype = 'dotted', color = quant_red, size = 1.25)+
  geom_vline(xintercept = 7.5, linetype = 'dotted', color = quant_red, size = 1.25)+
  geom_errorbar(aes(ymin = protest - 1.96*se,
                    ymax = protest + 1.96*se),
                width = 0.3)+
  geom_text(aes(label = round(protest, 4)*100),
            size = 4,
            vjust = 6.5)+
  labs(x = '',
       y = '% de personas mayores a 16 que han protestado',
       title = 'Participación en protestas del Ecuador 2006-2019',
       subtitle = '¿En los últimos 12 meses ha participado en una manifestación o protesta pública?',
       caption = str_wrap(caption_grafo1, 205))+
  theme_article_ds+
  theme(axis.ticks = element_blank())

ggsave("images/graf1-participacion-protestas.png", device = "png", width = 12.5, height = 7, dpi = 900)

# Algunas cifras para el texto:

# Realizamos tabulaciones cruzadas para observar características de los protestantes

lapop_prot_des2 <- subset(lapop_des, protest == 1) # Creamos un diseño de muestra que es solo para quienes responden haber participado en una protesta

# Realizamos tabulaciones de manifestantes: 

summ1 <- svyby(formula = ~ age + gndr + ed + econ_sit + unem_total,
        by = ~ year + protest,
        design = lapop_des,
        svymean,
        na.rm = T)

summ2 <- svyby(formula = ~ age + gndr + ed + econ_sit + unem_total,
              by = ~ protest,
              design = lapop_des,
              svymean,
              na.rm = T)

# Para trabajar con identificación racial, creamos indicador de autoidentificación indígena

df$indg<-ifelse(df$etid == 3,1,0) # Revisar documentación de la base de datos para entender esta parte

# Actualizamos el diseño muestral y la base de datos de protestantes

lapop_des<-svydesign(ids = ~ upm, 
                     strata = ~ estratopri, 
                     weights = ~ weight1500, 
                     nest = TRUE,
                     na.action = 'na.exclude',
                     data = df)

lapop_prot_des2 <- subset(lapop_des, protest == 1)

# Actualizamos las tabulaciones

summ1i <- svyby(formula = ~ age + gndr + ed + econ_sit + unem_total + indg + white + as.factor(etid) + pres_aprov_dic + plscr_na,
               by = ~ year + protest,
               design = lapop_des,
               svymean,
               na.rm = T)

summ2i <- svyby(formula = ~ age + gndr + ed + econ_sit + unem_total,
               by = ~ protest,
               design = lapop_des,
               svymean,
               na.rm = T)

# Grafico 2: Actitudes Políticas

# Tabulamos la variable de apoyo a las protestas en general, y construimos los datos en un formato que pueda entrar a ggplot2

# La variable toma valores de 1 al 10, siendo 10 que más apoyan las protestas en general. Escogemos a quienes responden 1-5
# como la gente que desaprueba el derecho a la protesta.

df$prot_desap<-ifelse(df$e5 > 5, 1, 0)

# Lo mismo con la variable de apoyo a las protestas de quienes hablan en contra del gobierno

df$prot_desap_op<-ifelse(df$d2 > 5, 1, 0)

# Actualizamos diseños muestrales

lapop_des<-svydesign(ids = ~ upm, 
                     strata = ~ estratopri, 
                     weights = ~ weight1500, 
                     nest = TRUE,
                     na.action = 'na.exclude',
                     data = df)

lapop_prot_des2 <- subset(lapop_des, protest == 1)

# Hacemos la tabulación a nivel de año

desap_time<-
  svyby(~ prot_desap,
        ~ year,
        design = lapop_des,
        svymean,
        na.rm = T)

desap_op_time<-
  svyby(~ prot_desap_op,
        ~ year,
        design = lapop_des,
        svymean,
        na.rm = T)

# Juntar todo

desap_time_df<-
  desap_time %>%
  mutate(legend = 'Aprueba las protestas en general') %>% 
  bind_rows(desap_op_time %>% 
              rename(prot_desap = prot_desap_op) %>% 
              mutate(legend = 'Aprueba las protestas de grupos de oposición al gobierno' ))

rownames(desap_time_df)<-NULL

# Tabulaciones

# Job Approval Rating

japrov_time<-svyby(~ pres_aprov_dic, 
                   ~ year, 
                   design = lapop_des,
                   svymean, 
                   na.rm = T)

# Confidence in the president

lapop_des$variables$pres_conf_dic <- as.factor(lapop_des$variables$pres_conf_dic)

pconf_time<-svyby(~ pres_conf_dic, 
                  ~ year, 
                  design = lapop_des,
                  svymean, 
                  na.rm = T)

# Manejo de datos

political_graph_df<-
  pconf_time %>%
  select(year, 
         pres_conf_dicYes, 
         se.pres_conf_dicYes) %>% 
  rename(perc = pres_conf_dicYes, 
         se = se.pres_conf_dicYes) %>% 
  mutate(legend = 'Confía en el Presidente') %>% 
  filter(year != 2004, 
         year != 2006)

# Lo mismo pero con el job approval rating

japrov_df_g<-
  japrov_time %>%
  select(year, 
         pres_aprov_dicYes, 
         se.pres_aprov_dicYes) %>% 
  rename(perc = pres_aprov_dicYes,
         se = se.pres_aprov_dicYes) %>% 
  mutate(legend = 'Aprueba el trabajo del Presidente')


# Unir a todas las bses para hacer el grafico

political_graph_df<-
  bind_rows(political_graph_df,
            japrov_df_g)

rownames(political_graph_df)<-NULL

# Subgrafico 1: actitudes

protestas_graph<-
  ggplot(desap_time_df, aes(x = year, y = prot_desap, color = legend, group = legend))+
  geom_line()+
  geom_line(aes(x = year, y = prot_desap - 1.96*se), color = quant_grey, linetype = 'dotted')+
  geom_line(aes(x = year, y = prot_desap + 1.96*se), color = quant_grey, linetype = 'dotted')+
  geom_point()+
  scale_color_manual(values = c('#964B00', quant_red),
                     breaks = c('Aprueba las protestas en general', 'Aprueba las protestas de grupos de oposición al gobierno'))+
  labs(x = '',
       y = '% de personas que aprueban protestas',
       title = 'Actitudes hacia protestas',
       subtitle = 'Porcentaje que aprueba la protesta pacífica',
       color = '')+
  theme_article_ds+
  theme(legend.position = c(0.35,0.12),
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 10))+
  scale_y_continuous(breaks = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9),
                     labels = c(10, 20, 30, 40, 50, 60, 70, 80, 90))

# Subgrafico 2: actitudes politicas

pol_graph<-
  ggplot(political_graph_df,
         aes(x = year, y = perc, color = legend, group = legend))+
  geom_line(size = 0.8)+
  scale_color_manual(values = c('#61346B','#BF69C2'),
                     breaks = c('Confía en el Presidente','Aprueba el trabajo del Presidente'))+
  geom_point(size = 2.15)+
  geom_line(aes(x = year, 
                y = perc - 1.96*se),
            size = 0.7,
            color = 'grey50', 
            linetype = 'dotted')+
  geom_line(aes(x = year, 
                y = perc + 1.96*se),
            size = 0.7,
            color = 'grey50', 
            linetype = 'dotted')+
  geom_vline(xintercept = 7.5, color = quant_grey, linetype = 'dotted')+
  annotate('label', x = 5, y = 0.4, label = 'Gob. de Correa')+
  geom_vline(xintercept = 2.5, color = quant_grey, linetype = 'dotted')+
  annotate('label', x = 1.48, y = 0.5, label = 'Gob. de\nGutiérrez-Palacio')+
  annotate('label', x = 8.05, y = 0.5, label = 'Gob. de\nMoreno')+
  theme_article_ds +
  labs(x = '',
       y = '% de aprobación',
       color = '',
       title = 'Actitudes hacia el gobierno',
       subtitle = 'Porcentaje que aprueba o confia en el Presidente de la República')+
  theme(legend.position = c(0.5,0.12),
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 10))+
  scale_y_continuous(breaks = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9),
                     labels = c(10, 20, 30, 40, 50, 60, 70, 80, 90))

# Caption largo

caption_grafo2<-
  'Fuente: El Barómetro de las Américas por el Proyecto de Opinión Pública de América Latina (LAPOP), www.LapopSurveys.org. Las barras representan intervalos de confianza al 95% con errores ajustados por diseño muestral multietapa y estratificado. Las encuestas fueron realizadas de enero a marzo de cada año excepto la ronda 2016, realizada de noviembre 2016 a enero 2017. Las líneas punteadas en gris representan los límites inferiores y superiores del intervalo de confianza al 95%. El porcentaje que aprueba las protestas se calcula para quienes responden números mayores a 4 (del 1 al 10). El porcentaje que confía en el Presidente se calcula para quienes responden números mayores a 4 (del 1 al 7) mientras que la aprobación se calcula para quienes responden números mayores a 3 (del 1 al 5). Los porcentajes son sobre el total de personas en edad de votar (mayores a 16) del Ecuador.'

# Ahora si se presenta ambos gráficos

grafo2<-
protestas_graph + pol_graph +
  plot_layout(ncol = 2) +
  plot_annotation(title = 'Actitudes políticas de los ecuatorianos en edad de votar 2006-2019',
                  caption = str_wrap(caption_grafo2, 210),
                  theme = theme(plot.caption = element_text(hjust = 0, face = 'italic'),
                                plot.title = element_text(hjust = 0.5)))

ggsave("images/graf2-politica-y-protestas.png", device = "png", width = 12.5, height = 7, dpi = 900)

# Tabulaciones cruzadas finales para %'s presentados al final y generación de la tabla:

summ3<-
  svyby(formula = ~ prot_desap + prot_desap_op,
        by = ~ protest + year,
        design = lapop_des,
        svymean,
        na.rm = T)

summ4<-
  svyby(formula = ~ prot_desap + prot_desap_op,
        by = ~ protest ,
        design = lapop_des,
        svymean,
        na.rm = T)


