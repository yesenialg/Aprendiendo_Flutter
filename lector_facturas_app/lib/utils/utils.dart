import 'package:flutter/widgets.dart';
import 'package:lector_facturas_app/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchInBrowser(BuildContext context, ScanModel scan) async {
  final cufe = scan.doc;
  const start = "CUFE=";
  const end = "\n";

  /*if (cufe.contains(start)) {*/
    final startIndex = cufe.indexOf(start);
    final endIndex = cufe.indexOf(end, startIndex + start.length);
    final idcufe = cufe.substring(startIndex + start.length, endIndex);

    final url_dian =
        'https://catalogo-vpfe.dian.gov.co/Document/ShowDocumentToPublic/$idcufe';

    if (await canLaunch(url_dian)) {
      await launch(url_dian);
    } else {
      throw 'Could not launch $url_dian';
    }
  /*} else {
    print('ESTE QR NO PERTENECE A LA DIAN');
  }*/
}
