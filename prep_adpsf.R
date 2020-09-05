# QC y ordenamiento de csv para entrar en bufr.

library(data.table)
library(metR)

path <- "../mesonet/"
date <- "20181118"

filelist <- list.files(path = paste0(path, date))

for (i in filelist) {
  message(i)
  file <- fread(paste0(path, date, "/", i), na.strings = c("NaN", "None", "Invalid", "-"))
  
  # Tiro pp
  
  pp <- c("precipitacion24horas_mm", "precipitacion6horas_mm", "precipitacion1hora_mm", "precipitacion10minutos_mm")
  file[, (pp) := NULL]
  
  # Calculo q y convierto las variables a lo que necesito
  file[, tk := temperatura_centigrados + 273.15]
  file[, p := presion_hPa*100]
  file[, es := ClausiusClapeyron(tk)]
  file[, e := humedad_porcentaje*es/100]
  file[, q := MixingRatio(p = presion_hPa*100, e = e)]
  file[, V := velocidadViento_km_hora*1000/3600]
  file[, u := - V*sin(direccionViento_grados*pi/180)]
  file[, v := - V*cos(direccionViento_grados*pi/180)]
  
  file <- file[, c("latitud_grados", "longitud_grados", "altura_mts", "estacion_codigo", "muestra_UTC", "temperatura_centigrados",
                   "q", "u", "v", "p")]
  colnames(file) <- c("LAT", "LON", "ELV", "STATION", "DATE", "TOB", "QOB", "UOB", "VOB", "PRSS")
  
  # Algo de QC
  
  file <- file[ (LAT %between% c(-90, 0))  & LON < 0 & !is.na(PRSS) & PRSS > 200 ]
  
  file[is.na(file)] <- 10.0e10
  
  # guardo el archivo
  
  fwrite(file, paste0("../out/", date, "/", i), na = '10.0e10', col.names = FALSE)
  
}

