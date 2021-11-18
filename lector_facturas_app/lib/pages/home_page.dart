import 'package:flutter/material.dart';
import 'package:lector_facturas_app/pages/historial_enlaces.dart';
import 'package:lector_facturas_app/providers/db_provider.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/widgets/custom_navigatorbar.dart';
import 'package:lector_facturas_app/widgets/history_button.dart';
import 'package:lector_facturas_app/widgets/scan_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Home page"),
        actions: [IconButton(
          onPressed: (){
            Provider.of<ScanListProvider>(context, listen: false).borrarScans();

          }, 
          icon: Icon(Icons.delete_forever),
        )],
      ),
      body: _cargarScans(),
        //bottomNavigationBar: CustomNavigatorBar(),
        floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ScanButton(),
          HistoryButton(),
        ],
      ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //bottomNavigationBar: ,
    );
  }
} 

class _cargarScans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    scanListProvider.cargarScans();

    return EnlacesPage();
  }
}