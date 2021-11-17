# lector_facturas_app

Proyecto para leer los QR de las facturas y almacenar la información de las mismas

## Estructura

El proyecto tiene una base de datos sqlite donde se almacena localmente la información leída de cada dispositivo.

- La creación y conexión de la base de datos está en db_provider
- En scan_list_provider se llaman los métodos del db_provider y se conviente en una listView que se mostrará en el historial_enlaces 

Se tiene un modelo para la estructura de cada Scan, que sería la que se encuentra en scan_list_provider, teniendo como requerido solo el cufe de cada scan
