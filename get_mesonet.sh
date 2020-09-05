#!/bin/bash
anio=2018
mes=11
dia=$1
fecha=${anio}${mes}${dia}

mkdir -p mesonet/${fecha}

for i in $(seq -f '%02g' 0 23)
do
	path='http://cimaps.cima.fcen.uba.ar/relampago/estaciones/'${anio}'/'${mes}'/'${dia}'/'${fecha}${i}'.csv'
	wget $path
#	echo $path
done

mv *.csv mesonet/${fecha}/

