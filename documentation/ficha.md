# Ficha del artículo

Completa esta ficha al crear el repositorio y mantenla al día. Es el único
lugar con datos propios del artículo; el README es igual en todos los
repositorios.

## Identificación

- **Título:** Una perspectiva cuantitativa sobre las protestas en Ecuador
- **Descripción del repositorio:** Repositorio del artículo de Daniel Sánchez: "Una perspectiva cuantitativa sobre las protestas en Ecuador"
- **Autoría:** Daniel Sánchez Pazmiño
- **Fecha de publicación:** 2022-07-16
- **Artículo publicado:** https://elquantificador.org/post/valores/perspectiva-cuantitativa-protestas-ecuador/
- **Categoría:** Política; Valores y comportamiento (el sitio lista ambas)
- **Edición:** Julio 2022-Enero 2023

## Estado

Publicado el 2022-07-16. En el sitio, el repositorio enlazado es `dsanchezp18/protests-article`; este es su repositorio en la organización.

## Pregunta y alcance

El artículo usa el Barómetro de las Américas de LAPOP para describir cómo se comportan los ecuatorianos frente a las protestas tras los 18 días de movilizaciones de junio de 2022: quiénes participan en protestas y cómo se relaciona esa participación con el respeto al derecho a protestar, la aprobación presidencial y la identificación política. La cobertura es nacional; la encuesta incluye preguntas sobre protestas desde 2006 y su última ronda con esas preguntas fue a inicios de 2019. La unidad de análisis es la persona encuestada.

## Requisitos

- R: no documentada en el repositorio.
- Paquetes de R: broom, car, haven, openxlsx, patchwork, survey, tidyverse. `protestas_analysis.R` los instala si faltan y `protestas_data_manipulation.R` los carga con `library()`.

## Fuentes de datos

| Fuente | Institución | Periodo | Acceso | Script |
|---|---|---|---|---|
| Barómetro de las Américas, bases públicas de Ecuador por ola (`.dta`) | Latin American Public Opinion Project (LAPOP), Vanderbilt University | 2004 a 2021 (la batería de protestas, de 2006 a 2019) | Manual: descarga desde el sitio de LAPOP | `code/protestas_data_manipulation.R` |
| Base consolidada de LAPOP para el análisis (archivo `.Rdata` en Google Drive) | LIDE, a partir de los datos públicos de LAPOP | 2004 a 2019 | Descarga automática desde Google Drive (id `1vthrTkGdU6BaNO-xOC9fF1f3g1NItYJc`) | `code/protestas_download.R` |

Enlace de LAPOP citado en el script: http://datasets.americasbarometer.org/database/index.php?freeUser=true. Para correr `code/protestas_data_manipulation.R` hay que colocar los archivos `ecu2004.dta` a `ecu2021.dta` en `data/dta/` (la carpeta `data/` no se versiona). El script también lee `data/csv/df20XX.csv` y `data/rdata/LAPOP 2004-2019 Merged.Rdata`; el origen de esos archivos no está documentado en el repositorio.

## Salidas

- `images/graf1-participacion-protestas.png`: participación en protestas en Ecuador a lo largo de las olas de la encuesta.
- `images/graf2-politica-y-protestas.png`: relación entre variables políticas y la participación en protestas.
- `data/rdata/LAPOP AAAA Manipulated Dataframe.Rdata` (y las versiones combinadas 2004-2019, 2004-2021 y 2014-2016): bases procesadas que guarda `code/protestas_data_manipulation.R`; no están versionadas.
- `report/texto-articulo.Rmd`, `.html` y `.docx`: texto del artículo; el Rmd carga las figuras desde `images/`.

## Cómo replicar en este repositorio

El README anterior da tres pasos, que coinciden con los scripts. Abre `protests-article.Rproj` y corre desde la raíz.

1. `code/protestas_download.R`: descarga la base consolidada desde Google Drive a un archivo temporal y la carga en memoria con `load()`.
2. `code/protestas_data_manipulation.R`: procesa las bases de LAPOP y guarda las bases manipuladas en `data/rdata/`. Necesita los archivos de LAPOP colocados a mano (ver "Fuentes de datos"). El propio script advierte que debe correrse completo cada vez.
3. `code/protestas_analysis.R`: hace `source('code/protestas_download.R')` por su cuenta, de modo que obtiene los datos de Drive y no de los archivos del paso 2, y genera las dos figuras en `images/`. Por eso el paso 2 solo hace falta para reconstruir la base desde LAPOP.
4. Para ver el artículo, abre `report/texto-articulo.Rmd` y usa Knit.

## README anterior

Texto del README de este repositorio antes de adoptar el README estándar,
conservado sin cambios de contenido para no perder información.

### Una perspectiva cuantitativa sobre las protestas en Ecuador

Este repositorio contiene el código y los archivos necesarios para analizar la participación en protestas en Ecuador utilizando los datos de LAPOP.

#### Requisitos
- R (se recomienda usar RStudio).
- Paquetes de R que se instalarán automáticamente al ejecutar los scripts.
- Opcionalmente LaTeX para compilar el artículo en PDF.

#### Cómo reproducir el análisis
1. Clona o descarga este repositorio.
2. Ejecuta `code/protestas_download.R` para descargar la base de datos desde Google Drive.
3. Corre `code/protestas_data_manipulation.R` para procesar y guardar las bases de datos.
4. Finalmente ejecuta `code/protestas_analysis.R` para generar las figuras y el artículo.

Para mas información, revisa el perfil de GitHub del [autor](https://github.com/dsanchezp18).
