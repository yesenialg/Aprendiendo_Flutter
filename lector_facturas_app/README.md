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


Se tiene un modelo para la estructura de cada Scan, que sería la que se encuentra en scan_list_provider, teniendo como requerido solo el cufe de cada scan
