import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        if (barcodeScanRes != '-1') {
            final scanListProvider =
                Provider.of<ScanListProvider>(context, listen: false);
            var doc = barcodeScanRes.toString();
            if (doc.contains("CUFE")) {
            final num_factura = getDataQR(doc, 'NroFactura=', '\n');
            final establecimiento= getDataQR(doc, 'NitAdquiriente=', '\n');
            final cufe = getDataQR(doc, 'CUFE=', '\n');
            final fecha= getDataQR(doc, 'FechaFactura=', '\n');
            final total= double.parse(getDataQR(doc, 'ValorTotalFactura=', '\n')).round();
            final nuevoScan = await scanListProvider.nuevoScan(
                 cufe,fecha, total, num_factura, doc, establecimiento);
            //print(scanListProvider);
            launchInBrowser(context, nuevoScan);
          } else {
            print('ESTE QR NO PERTENECE A LA DIAN');
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

  String getDataQR(String str, String start, String end) {
    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);

    return (str.substring(startIndex + start.length, endIndex));
  }
}
