import 'package:flutter/material.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

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
      itemBuilder: (BuildContext context, i) => Dismissible(
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
            return;
          }
        },
        child: _buildScanModelList(context, scans, i),
      ),
    );
  }
}

Widget _buildScanModelList(BuildContext context, List scans, int i) {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  return Padding(
   padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
    child: ExpansionTileCard(
      key: cardA,
      baseColor: Colors.cyan[50],
      expandedColor: Colors.red[50],
      leading: CircleAvatar(child: Icon(Icons.payment_outlined)),
      title: Text(
        ' Nro Fcatura: ' + scans[i].num_factura,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      children: <Widget>[
        ListTile(
          title: Text(
            'FECHA: ' +
                scans[i].fecha +
                '\n' +
                'Valor Total: ' +
                scans[i].total.toString() +
                '\n' +
                'Facturador: ' +
                scans[i].establecimiento +
                '\n' +
                'CUFE: ' +
                scans[i].cufe,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          buttonHeight: 52.0,
          buttonMinWidth: 90.0,
          children: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              onPressed: () {
                cardA.currentState?.collapse();
              },
              child: Column(
                children: <Widget>[
                  Icon(Icons.arrow_upward),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Text('Cerrar'),
                ],
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              onPressed: () {
                launchInBrowser(context, scans[i]);
              },
              child: Column(
                children: <Widget>[
                  Icon(Icons.web),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Text('DIAN'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
