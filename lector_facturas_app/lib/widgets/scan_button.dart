import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lector_facturas_app/models/scan_model.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/providers/variables_qr_provider.dart';
import 'package:lector_facturas_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanButton extends StatelessWidget {
  
  List<dynamic> json = [];
  List<String> variables_qr = [];
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "scan",
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        if (barcodeScanRes != '-1') {
          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);
          String doc = barcodeScanRes.toString();

          var newString = 'resume';
          var doc2 = doc.replaceAll(':', '=');
          var doc3 = doc2.replaceAll(' ', '');
          if (doc.contains("CUFE")) {
             for (int i = 0; i < 6; i++) {
            json.add(await variablesQrProvider.cargarData(i));
          }

          for (int i = 0; i < json.length; i++) {
            for (int j = 0; j < json[i].length; j++) {
              if (doc.contains(json[i][j])) {
                variables_qr.add(json[i][j]);
              }
            }
          }

          for (int i = 0; i < variables_qr.length; i++) {
            print(variables_qr[i]);
          }

            final cufe = getDataQR(doc3, variables_qr[0]+'=', '\n');
            final num_factura = getDataQR(doc3, variables_qr[1]+'=', '\n');
            final fecha = getDataQR(doc3, variables_qr[2]+'=', '\n');
            final total =
                double.parse(getDataQR(doc3, variables_qr[3]+'=', '\n'))
                    .round();
            final establecimiento = getDataQR(doc3, variables_qr[4]+'=', '\n');
            //final adquiriente=getDataQR(doc3, variables_qr[5]+'=', '\n');
            var scan = await equalQR(cufe, context);
            // ignore: prefer_conditional_assignment
            if (scan == null) {
              scan = await scanListProvider.nuevoScan(
                  cufe, fecha, total, num_factura, doc, establecimiento);
            }
            final url_dian='https://catalogo-vpfe.dian.gov.co/Document/ShowDocumentToPublic/$cufe';
            await launch(url_dian);
          } else {
            ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.danger, title: "ESTE QR NO PERTENECE A LA DIAN"));
            return;
          }
        } else {
          return;
        }
      },
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
    );
  }

  Future<ScanModel?> equalQR(String cufe, BuildContext context) async {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    Future? exis = await scanListProvider.getScanByCufe(cufe);
    List existente = scanListProvider.scans;
    if (!existente.isEmpty) {
      return existente[0];
    } else {
      return null;
    }
  }

  String getDataQR(String str, String start, String end) {
    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);

    return (str.substring(startIndex + start.length, endIndex));
  }
}
