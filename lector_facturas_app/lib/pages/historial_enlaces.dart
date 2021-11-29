import 'package:flutter/material.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String tipo = 'CUFE';
  if(scans[i].tipo!='Factura'){ tipo='CUDE';}
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
    child: ExpansionTileCard(
      key: cardA,
      baseColor: Colors.indigo[50],
      expandedColor: Colors.indigo[50],
      expandedTextColor: Colors.indigo,
      leading: CircleAvatar(
          child: Icon(Icons.payment_outlined, color: Colors.white),
          backgroundColor: Colors.indigo),
      title: Text(
        ' Nro Factura: ' + scans[i].num_factura,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      
      ),
      subtitle:Text(' Tipo: ' + scans[i].tipo, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
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
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          buttonHeight: 52.0,
          buttonMinWidth: 90.0,
          children: <Widget>[
            TextButton(
              onPressed: () {
                cardA.currentState?.collapse();
              },
              child: Column(
                children: <Widget>[
                  Icon(Icons.arrow_upward, color: Colors.indigo),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Text(
                    "Cerrar",
                    style: TextStyle(color: Colors.indigo),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                final url_dian =
                    'https://catalogo-vpfe.dian.gov.co/Document/ShowDocumentToPublic/${scans[i].cufe}';
                await launch(url_dian);
              },
              child: Column(
                children: <Widget>[
                  Icon(Icons.web, color: Colors.indigo),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Text(
                    'DIAN',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}