import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:lector_facturas_app/pages/historial_enlaces.dart';
import 'package:lector_facturas_app/pages/table_enlaces.dart';
import 'package:lector_facturas_app/providers/db_provider.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/widgets/calendar.dart';
import 'package:lector_facturas_app/widgets/custom_navigatorbar.dart';
import 'package:lector_facturas_app/widgets/filter_button.dart';
import 'package:lector_facturas_app/widgets/history_button.dart';
import 'package:lector_facturas_app/widgets/scan_button.dart';
import 'package:provider/provider.dart';

class TablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Table page"),
      ),
            body: EnlacesTable()
        
      ,
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => _mostrarAlert(context),
            icon: const Icon(Icons.calendar_today),
          ),
          ActionButton(
            onPressed: () => _cargarScans(),
            icon: const Icon(Icons.cleaning_services),
          ),
        ],
      ),
    );
  }
}

  void _mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)),
            title: Text('Titulo'),
            //content:Text('Contenido'),
            content: Column(
                //Evitar que la columna de la tarjeta se estire// se adapte al contenido interno
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text('Este es el contenido de la caja de la tarjeta'),
                  Calendar()
                ]),
            actions: <Widget>[
              TextButton(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop()),
              TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }



//EnlacesTable(),
class _cargarScans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    scanListProvider.cargarScans();

    return EnlacesTable();
  }
}
