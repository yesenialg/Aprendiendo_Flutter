import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/utils/utils.dart';
import 'package:provider/provider.dart';

class HistoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
     heroTag: "history",
     elevation: 50,
      onPressed: () {
        Navigator.pushNamed(context, 'table');
        
      },
      child: Icon(Icons.history),
    );
  }

}
