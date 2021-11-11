import 'package:flutter/material.dart';
import 'package:lector_facturas_app/pages/historial_enlaces.dart';
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
      body: EnlacesPage(),
        //bottomNavigationBar: CustomNavigatorBar(),
        floatingActionButton: ScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //bottomNavigationBar: ,
    );
  }
} 