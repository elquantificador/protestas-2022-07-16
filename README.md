# Una perspectiva cuantitativa sobre las protestas en Ecuador

Este repositorio contiene el código y los archivos necesarios para analizar la participación en protestas en Ecuador utilizando los datos de LAPOP.

## Requisitos
- R (se recomienda usar RStudio).
- Paquetes de R que se instalarán automáticamente al ejecutar los scripts.
- Opcionalmente LaTeX para compilar el artículo en PDF.

## Cómo reproducir el análisis
1. Clona o descarga este repositorio.
2. Ejecuta `code/protestas_download.R` para descargar la base de datos desde Google Drive.
3. Corre `code/protestas_data_manipulation.R` para procesar y guardar las bases de datos.
4. Finalmente ejecuta `code/protestas_analysis.R` para generar las figuras y el artículo.

El proyecto se basa en parte en mi trabajo de tesis de pregrado, [Honesty By Convenience: Corruption Tolerance in Ecuador](https://daniel-ec.netlify.app/research.html). Puedes revisar [hbc-prelim](https://github.com/dsanchezp18/hbc-prelim) y [hbc-v2](https://github.com/dsanchezp18/hbc-v2) para ver los scripts originales de manipulación de datos.
