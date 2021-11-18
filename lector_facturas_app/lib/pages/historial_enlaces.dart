import 'package:flutter/material.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class EnlacesPage extends StatefulWidget {
  @override
  _EnlacesPageState createState() => _EnlacesPageState();
}

class _EnlacesPageState extends State<EnlacesPage> {
  @override
  Widget build(BuildContext context) {
    ScanListProvider scanListProvider = Provider.of<ScanListProvider>(context);
    List scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) async {
          ArtDialogResponse response = await ArtSweetAlert.show(
              barrierDismissible: false,
              context: context,
              artDialogArgs: ArtDialogArgs(
                denyButtonText: "Cancelar",
                title: "¿Quieres eliminar el registro?",
                confirmButtonText: "Eliminar",
              ));

          if (response.isTapConfirmButton) {
            Provider.of<ScanListProvider>(context, listen: false)
                .borrarScan(scans[i].id);
            ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.success, title: "Eliminado!"));
            return;
          }

          if (response.isTapDenyButton) {
            scans = scanListProvider.scans;
            setState(() {});
            ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.info, title: "Cancelado"));
            return;
          }
        },
        child: Card(
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(children: <Widget>[
            ListTile(
              leading: Icon(Icons.home, color: Theme.of(context).primaryColor),
              title: Text('Nro Factura' + scans[i].num_factura),
              subtitle: Text('ID: ' +
                  scans[i].id.toString() +
                  '\n' +
                  'FECHA: ' +
                  scans[i].fecha +
                  '\n' +
                  'Valor: ' +
                  scans[i].total.toString()),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () {
                launchInBrowser(context, scans[i]);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
