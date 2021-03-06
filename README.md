# CRUD
#### Asignatura: Programación
#### Centro: IES Campanillas FP
#### Curso: 1º DAW 2017/2018

## Descripción:
Este crud una aplicación web, llamada Gestuino, para la gestión de proyectos de arduino en la cuál, a través de la interfaz podremos, crear, modificar y eliminar proyectos. También se podrán añadir artículos así como asignarlos a un proyecto determinado. Se han utilizado los lenguajes de programacion: **HTML, CSS, JSP, MySQL y JavaScript**

## A tener en cuenta:
**Esta aplicación web cuenta con dos liberías** para la subida de archivos mediante formulario, que pueden no estar incluidas en el entorno de desarrollo que se esté utilizando. Estos archivos jar se han adjuntado en la carpeta [Archivos de liberia](https://github.com/jfbernal92/CRUD/tree/master/Archivos%20de%20libreria). Para importarlos correctamente en **netbeans** hay que hacer lo siguiente:

![1.jpg](https://github.com/jfbernal92/CRUD/blob/master/Images/1.jpg)
![2.jpg](https://github.com/jfbernal92/CRUD/blob/master/Images/2.jpg)
![3.jpg](https://github.com/jfbernal92/CRUD/blob/master/Images/3.jpg)
![4.png](https://github.com/jfbernal92/CRUD/blob/master/Images/4.png)

En la última foto se puede observar que **también hay que incluirlas en la carpeta lib, dentro de WEB-INF**

# Esquema de la Base de Datos
El esquema de la base de datos es el que se muestra en la imagen siguiente. Este es el script para su creación en MySQL: [Script.sql](https://github.com/jfbernal92/CRUD/blob/master/Script.sql)

![5.png](https://github.com/jfbernal92/CRUD/blob/master/Images/5.png)

# Características de la aplicación
- Inserta, modifica y elimina datos en la misma página gracias al modal de bootstrap.
- Mensajes de confirmación, alerta o error para cada acción que el usuario realiza.
- Posibilidad de enviar imágenes a través del formulario.
- Capturado errores al repetir datos o enviar datos del tipo incorrecto.

# Imágenes del funcionamiento

## Gestión de Proyectos
![6.png](https://github.com/jfbernal92/CRUD/blob/master/Images/6.png)
![7.png](https://github.com/jfbernal92/CRUD/blob/master/Images/7.png)
![8.png](https://github.com/jfbernal92/CRUD/blob/master/Images/8.png)
![9.png](https://github.com/jfbernal92/CRUD/blob/master/Images/9.png)

## Gestión de Artículos
![10.png](https://github.com/jfbernal92/CRUD/blob/master/Images/10.png)
![11.png](https://github.com/jfbernal92/CRUD/blob/master/Images/11.png)
![12.png](https://github.com/jfbernal92/CRUD/blob/master/Images/12.png)
![13.png](https://github.com/jfbernal92/CRUD/blob/master/Images/13.png)

## Gestión de Artículos necesarios para realizar un Proyecto
![14.png](https://github.com/jfbernal92/CRUD/blob/master/Images/14.png)
![15.png](https://github.com/jfbernal92/CRUD/blob/master/Images/15.png)
![16.png](https://github.com/jfbernal92/CRUD/blob/master/Images/16.png)


## Mensajes de confirmación, alerta o error al manipular datos
![17.png](https://github.com/jfbernal92/CRUD/blob/master/Images/17.png)
![18.png](https://github.com/jfbernal92/CRUD/blob/master/Images/18.png)
![19jpg](https://github.com/jfbernal92/CRUD/blob/master/Images/19.png)
![20.png](https://github.com/jfbernal92/CRUD/blob/master/Images/20.png)
