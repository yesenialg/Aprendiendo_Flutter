import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lector_facturas_app/models/scan_model.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/providers/variables_qr_provider.dart';
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
        try {
          variables_qr.clear();
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#3D8BEF', 'Cancelar', false, ScanMode.QR);

          if (barcodeScanRes != '-1') {
            final scanListProvider =
                Provider.of<ScanListProvider>(context, listen: false);
            String doc = barcodeScanRes.toString();

            if (doc.contains("CUFE") || doc.contains("CUDE")) {
              String tipo = '';
              doc.contains("CUFE") ? tipo = 'Factura' : tipo = 'Nota credito';
              var cufe =
                  await separarDatos(doc, scanListProvider, context, tipo);
              final url_dian =
                  'https://catalogo-vpfe.dian.gov.co/Document/ShowDocumentToPublic/$cufe';
              await launch(url_dian);
            } else {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.danger,
                      title: "Este QR no pertenece a la DIAN"));
              return;
            }
          } else {
            return;
          }
        } catch (e) {
          print(e);
          ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "No se pudo leer el QR, intentelo de nuevo"));
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
    await scanListProvider.cargarScans();
    if (!existente.isEmpty) {
      return existente[0];
    } else {
      return null;
    }
  }

  String getDataQR(String str, String start, String end) {
    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);
    String variable = str.substring(startIndex + start.length, endIndex);

    return (variable.replaceAll(" ", ""));
  }

  Future<String?> separarDatos(doc, scanListProvider, context, tipo) async {
    variables_qr.clear();
    int enter = 0;

    doc.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      if (character == '\n') {
        enter++;
      }
    });

    if (enter < 2) {
      doc = doc.replaceAll(" ", '\n') + '\n';
    }

    for (int i = 0; i < 6; i++) {
      json.add(await variablesQrProvider.cargarData(i));
    }
    variables_qr.clear();

    for (int i = 0; i < json.length; i++) {
      for (int j = 0; j < json[i].length; j++) {
        if (doc.contains(json[i][j])) {
          variables_qr.add(json[i][j]);
          break;
        }
      }
    }


    String cufe = getDataQR(doc, variables_qr[0], '\n');
    cufe = cufe.replaceAll(" ", "").replaceAll('\n', "");
    String num_factura = getDataQR(doc, variables_qr[1], '\n');
    num_factura = num_factura.replaceAll(" ", "").replaceAll('\n', "");
    String fecha = getDataQR(doc, variables_qr[2], '\n');
    fecha = fecha.replaceAll(" ", "").replaceAll('\n', "");
    String total = (getDataQR(doc, variables_qr[3], '\n'));
    total = total.replaceAll(" ", "").replaceAll('\n', "");
    String establecimiento = getDataQR(doc, variables_qr[4], '\n');
    establecimiento = establecimiento.replaceAll(" ", "").replaceAll('\n', "");
    //final adquiriente=getDataQR(doc, variables_qr[5]+'=', '\n');
    var scan = await equalQR(cufe, context);
    // ignore: prefer_conditional_assignment

    if (scan == null) {
      scan = await scanListProvider.nuevoScan(cufe, fecha, double.parse(total),
          num_factura, doc, establecimiento, tipo);
    }

    return cufe;
  }
}
