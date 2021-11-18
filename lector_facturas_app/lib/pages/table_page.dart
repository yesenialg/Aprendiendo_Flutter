import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:lector_facturas_app/pages/historial_enlaces.dart';
import 'package:lector_facturas_app/pages/table_enlaces.dart';
import 'package:lector_facturas_app/providers/db_provider.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/widgets/custom_navigatorbar.dart';
import 'package:lector_facturas_app/widgets/history_button.dart';
import 'package:lector_facturas_app/widgets/scan_button.dart';
import 'package:provider/provider.dart';

class TablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Table page"),
      ),
      body:
      EnlacesTable(),
      

    );
  }
}




class _cargarScans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    scanListProvider.cargarScans();

    return EnlacesTable();
  }
}
