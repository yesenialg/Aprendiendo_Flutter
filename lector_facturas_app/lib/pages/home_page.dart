import 'package:flutter/material.dart';
import 'package:lector_facturas_app/pages/historial_enlaces.dart';
import 'package:lector_facturas_app/providers/db_provider.dart';
import 'package:lector_facturas_app/widgets/custom_navigatorbar.dart';
import 'package:lector_facturas_app/widgets/scan_button.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Home page"),
        actions: [IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.delete_forever),
        )],
      ),
      body: demo(),
        //bottomNavigationBar: CustomNavigatorBar(),
        floatingActionButton: ScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //bottomNavigationBar: ,
    );
  }
} 

class demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DBProvider.db.database;
    final tempScan = new ScanModel(valor: 'http://google.com');
    DBProvider.db.nuevoScan(tempScan);
    return EnlacesPage();
  }
}