# lector_facturas_app

Proyecto para leer los QR de las facturas y almacenar la información de las mismas

## Estructura

El proyecto tiene una base de datos sqlite donde se almacena localmente la información leída de cada dispositivo.

- La creación y conexión de la base de datos está en db_provider
- En scan_list_provider se llaman los métodos del db_provider y se conviente en una listView que se mostrará en el historial_enlaces 
- En el utils se ejecuta un metodo que recibe un CUFE de la DIAN y de ser valido se le redirecciona a la pagina de la 
DIAN, en la cual se visualiza un detalle más amplio de la factura
- En scan_button se ejecuta la función que habilita la camara del dispositivo y lee el codigo QR, allí se valida que el 
codigo scaneado corresponda con una factura de la DIAN, luego de esto se extraen y almacenan los datos que se obtienen de la factura y por último se redirecciona a la pagina de la DIAN (se invoca el utils)
- Para contar con un historial organizado y consistente con los datos se cuenta con el archivo table_enlaces, aquí se 
podrá visualizar una tabla de datos con el historial de facturas registradas por el usuario del dispositivo (La tabla cuenta con un metodo para organizar los datos, para esto se selecciona cualquiera de las variables del encabezado para organizarse de manera ascendente o descendente). En este historial que proporciona la tabla se comenzó con la implementacion de un filtro, el cual en esta primera fase contará con la opción de filtar por fecha o limpiar el filtro (opciones dadas por medio de un radio button)
-Para esta implemntación se deberá hacer las respectivas validaciones de que la factura electronica perteneza a la DIAN (para esto se esta haciendo un diccioanrio de datos para que los datos tengan consistencia al almacenarse) y tambien leer notas de credito o debito

Se tiene un modelo para la estructura de cada Scan, que sería la que se encuentra en scan_list_provider, teniendo como requerido solo el cufe de cada scan
