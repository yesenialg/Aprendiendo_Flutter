import 'package:flutter/material.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/utils/utils.dart';
import 'package:provider/provider.dart';

class EnlacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direcction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScan(scans[i].id);
        },
        child: Card(
          elevation: 10.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(children: <Widget>[
            ListTile(
              leading: Icon(Icons.home, color: Theme.of(context).primaryColor),
              title: Text('Nro Factura'+scans[i].num_factura ),
              subtitle: Text(
                'ID: '+scans[i].id.toString() +'\n'+
                'FECHA: ' + scans[i].fecha +'\n'+
                'Valor: ' + scans[i].total.toString())
                ,
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () {
                launchInBrowser(context, scans[i]);
              },
            ),
          ]
        ),
        ),
      ),
    );
  }
}
