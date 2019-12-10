#!/bin/bash
#
# @autor: Ing. Yubisel Vega Alvarez
# e-m@il: yubiselv@gmail.com
#
#   DESCRIPTION:   Configuracion de host virtual en Ubuntu
#
#     USAGE:   sh config-vhost.sh
#
#
if [ "`whoami`" != root ]; then
 echo "Debe ejecutar $0 como root"
 exit 0
fi

#variables
DEFAULT_CONFIG='default-vhost.conf'

echo "Parametros para configurar el host virtual"
#entrada de datos
echo "Introduce el nombre del host:"
read VHOST
echo "Introduce la direccion del proyecto:"
read PDIR

#chequeo que exista el directorio introducido para el host
if [ ! -d "${PDIR}" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  echo "La url ${PDIR} especificada para el host no existe"
  exit 0
fi

#hago copia del fichero modelo de configuracion para ponerle los parametros
cp ${DEFAULT_CONFIG} ${VHOST}.conf
echo "Creada copia del fichero de configuracion para el host virtual"

#sustituyo los parametros en el nuevo fichero del host virtual
sed -i "s%VHOSTURL%${VHOST}%g" ${VHOST}.conf
echo "Reemplazada variable del host virtual en el fichero de configuracion"
sed -i "s%PROYECTURL%${PDIR}%g" ${VHOST}.conf
echo "Reemplazada ruta del proyecto en el fichero de configuracion"

#muevo la copio del fichero de configuracion a la carpeta de apache
mv ${VHOST}.conf /etc/apache2/sites-available/${VHOST}.conf
echo "Moviendo el fichero de configuracion a la carpeta de apache"

#creo la entrada en el fichero hosts del sistema 
echo "127.0.0.1         ${VHOST}">> /etc/hosts
echo "Creada la entrada en los hosts del sistema"

#habilito el sitio
a2ensite ${VHOST}

#reinicio el apache
systemctl restart apache2
echo "Reiniciando servicio de apache"