#!/bin/sh

# Verificar si el archivo de respaldo de configuración no existe
if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

    # Crear el directorio de WordPress si no existe
    mkdir -p /var/www/html

    # Hacer una copia de seguridad del archivo de configuración y mover el nuevo archivo
    cp ./etc/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
    cp ./tmp/vsftpd.conf /etc/vsftpd.conf

    # Crear el usuario FTP, configurar la contraseña y dar permisos sobre el directorio de WordPress
    adduser $FTP_USR --disabled-password --gecos ""  # --gecos para evitar una pregunta interactiva
    echo "$FTP_USR:$FTP_PWD" | /usr/sbin/chpasswd &> /dev/null
    chown -R $FTP_USR:$FTP_USR /var/www/html

    # Añadir el usuario a la lista de usuarios de vsftpd
    echo $FTP_USR | tee -a /etc/vsftpd.userlist &> /dev/null
fi

# Iniciar el servicio FTP
echo "FTP started on :2121"
/usr/sbin/vsftpd /etc/vsftpd.conf
