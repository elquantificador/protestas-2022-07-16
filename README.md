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

Para mas información, revisa el perfil de GitHub del [autor](https://github.com/dsanchezp18).


## Licencias y cómo citar

- **Código:** [MIT](LICENSE).
- **Texto, figuras y tablas:** [CC BY-NC 4.0](LICENSE-content).
- **Datos de terceros:** conservan los términos de su fuente
  ([aviso](DATA-NOTICE.md)).
- **Nombre y logotipos:** todos los derechos reservados.

Las cifras y resultados pueden citarse libremente. Menciona a los autores y a
El Quantificador (LIDE) y enlaza la publicación original. Los usos comerciales
de gráficos, tablas o texto requieren autorización previa:
elquantificador@laboratoriolide.org. Ver también `CITATION.cff`.
