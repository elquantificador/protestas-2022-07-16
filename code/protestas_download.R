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

# ---- DESCARGAR DATOS ----

id<-"1vt-5HmDpuTs0x2bZI5WIbp9iiPC6K6A2"
url <- paste("https://drive.google.com/uc?export=download&id=", 
             id, 
             sep = "")

download.file(url = url, destfile = 'data/lapop_full.csv', mode = "wb")

