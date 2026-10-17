# Repositorio de replicación de El Quantificador

Este repositorio reúne los datos, el código y el artículo de una publicación
de [El Quantificador](https://elquantificador.org/), el blog de análisis
cuantitativo del Laboratorio de Investigación para el Desarrollo del Ecuador
(LIDE). Todos los repositorios de artículos de El Quantificador tienen este
mismo README y esta misma estructura de carpetas.

Los datos propios de cada artículo (título, autoría, fuentes, estado y
salidas) están en [`documentation/ficha.md`](documentation/ficha.md).

## Cómo replicar

1. Clona el repositorio y abre el archivo `.Rproj` de la raíz con RStudio, o
   abre una terminal en la raíz del repositorio.
2. Instala los paquetes de R que figuran en `documentation/ficha.md`.
3. Corre desde la raíz:

   ```text
   Rscript MASTER.R
   ```

`MASTER.R` descarga los insumos a `data/raw/`, los limpia, calcula los
resultados y escribe tablas y figuras en `outputs/`. También copia las
figuras numeradas a `article/images/`.

Los repositorios anteriores a 2026 que todavía no tienen `MASTER.R` explican
cómo replicar en `documentation/ficha.md`.

Para ver el artículo, abre `article/index.Rmd` en RStudio y usa Knit. La
versión publicada se genera desde el repositorio del sitio con `blogdown`.

## Requisitos

- R y los paquetes listados en `documentation/ficha.md`.
- Los scripts no instalan paquetes. Si falta alguno, R se detiene en
  `library()` y te dice cuál es.
- Para revisar el estilo del código: `lintr` y `styler`
  (`Rscript code/setup/style_project.R`).

## Estructura

```text
MASTER.R               Punto de entrada: ejecuta el pipeline en orden
article/               Artículo listo para copiar al sitio (index.Rmd)
code/cleaning/         Descarga y limpieza de cada fuente
code/analysis/         Cálculos, tablas y figuras
code/functions/        Funciones compartidas por más de un script
code/setup/            Herramientas fuera del pipeline (estilo y lint)
data/raw/              Descargas originales, sin modificar (no se versionan)
data/intermediate/     Bases limpias por fuente (no se versionan)
data/final/            Bases listas para el análisis (no se versionan)
documentation/         Ficha del artículo, fuentes, diccionarios y notas
outputs/graphs/        Figuras generadas por el código
outputs/tables/        Tablas generadas por el código
```

## Datos

Las fuentes de cada artículo están en `documentation/fuentes.csv`, con su
enlace oficial. Los datos crudos no se versionan: el script de descarga los
vuelve a obtener. Los datos de terceros conservan los términos de su fuente
(ver `DATA-NOTICE.md`).

## Publicación en el sitio

Copia el contenido de `article/` a `content/post/[categoria]/[slug]/` en el
repositorio del sitio. Revisa que `authors` coincida con un archivo de
`content/los-quantificadores/` y que `repository_url` apunte a este
repositorio.

Si un gráfico del artículo se publica también en redes o en Visualizaciones,
se rehace en `graficos-el-quantificador` a partir de una tabla de
`data/final/` o `outputs/tables/`, con su propia fila en el catálogo.

## Licencias y cómo citar

- **Código:** [MIT](LICENSE).
- **Texto, figuras y tablas:** [CC BY-NC 4.0](LICENSE-content).
- **Datos de terceros:** conservan los términos de su fuente
  ([aviso](DATA-NOTICE.md)).
- **Nombre y logotipos:** todos los derechos reservados.

Las cifras y resultados pueden citarse libremente. Menciona a los autores y a
El Quantificador (LIDE) y enlaza la publicación original. Los usos comerciales
de gráficos, tablas o texto requieren autorización previa:
elquantificador@laboratoriolide.org. Ver también `CITATION.cff` y
`CONTRIBUTING.md`.
