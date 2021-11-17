import 'package:flutter/widgets.dart';
import 'package:lector_facturas_app/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchInBrowser(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
}
