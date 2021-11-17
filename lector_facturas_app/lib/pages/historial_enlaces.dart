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
              title: Text(
                scans[i].valor.substring(( scans[i].valor.indexOf('NroFactura=')) + 'NroFactura='.length,scans[i].valor.indexOf('\n', ( scans[i].valor.indexOf('NroFactura=')) + 'NroFactura='.length))
              ),
              subtitle: Text(
                'ID: '+scans[i].id.toString() +'\n'+
                'FECHA: ' + scans[i].valor.substring(( scans[i].valor.indexOf('FechaFactura=')) + 'FechaFactura='.length,scans[i].valor.indexOf('\n', ( scans[i].valor.indexOf('FechaFactura=')) + 'FechaFactura='.length))+'\n'+
                'VALOR: ' + scans[i].valor.substring(( scans[i].valor.indexOf('ValorTotalFactura=')) + 'ValorTotalFactura='.length,scans[i].valor.indexOf('\n', ( scans[i].valor.indexOf('ValorTotalFactura=')) + 'ValorTotalFactura='.length))
                ),
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
