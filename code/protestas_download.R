# ---- DESCARGAR DATOS ----

id<-"1vthrTkGdU6BaNO-xOC9fF1f3g1NItYJc"
url <- paste("https://drive.google.com/uc?export=download&id=", id, sep = "")

# temporary
td <- tempdir()

# creates a placeholder file
tf <- tempfile(tmpdir = td,
               fileext = ".Rdata") # file extension

# downloads the data into the placeholder file - warning mode = "wb" for windows
download.file(url = url, destfile = tf, mode = "wb")

load(tf)
