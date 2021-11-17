import 'package:flutter/widgets.dart';
import 'package:lector_facturas_app/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchInBrowser(BuildContext context, ScanModel scan) async {
  final valor = scan.valor;
  const start = "CUFE=";
  const end = "\n";

  final startIndex = valor.indexOf(start);
  final endIndex = valor.indexOf(end, startIndex + start.length);
  final cufe= valor.substring(startIndex + start.length, endIndex);

  final url_dian='https://catalogo-vpfe.dian.gov.co/Document/ShowDocumentToPublic/$cufe';

     if (await canLaunch(url_dian)) {
      await launch(url_dian);
    } else {
      throw 'Could not launch $url_dian';
    } 
}
