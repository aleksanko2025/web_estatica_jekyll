#!/bin/bash

#--------------------------------ZONA DE FUNCIONES-----------------------------------------------------

#Aquí la automatización para actualizar la página en Netlify

function push_to_origin(){

    #Primero hacemos el commit de los cambios a nuestro repositorio principal web_estatica_jekyll 

    cd /home/aleksanko/web_estatica_jekyll
    jekyll build
    git add -A
    echo "Introduzca el mensaje para el commit a web_estatica_jekyll: "
    read mensaje
    git commit -m "$mensaje"
    git push origin main


}


function push_to_web(){

    #Una vez generado _site lo copiamos al directorio del repositorio kernel-panic-bykosenko

    cp -u /home/aleksanko/web_estatica_jekyll/_site/*  /home/aleksanko/kernel-panic-bykosenko

    cd /home/aleksanko/kernel-panic-bykosenko

    git add -A
    echo "Introduzca el mensaje para el commit a kernel-panic-bykosenko: "
    read mensaje
    git commit -m "$mensaje"
    git push origin main
}

#---------------------------------ZONA DE EJECUCIÓN---------------------------------------------------------

push_to_origin
push_to_web