import 'package:flutter/material.dart';
import 'package:flutter_componentes/src/pages/alert_page.dart';
import 'package:flutter_componentes/src/providers/menu_provider.dart';
import 'package:flutter_componentes/src/utils/icono_string_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Componentes")),
      body: _lista(),
    );
  }

  Widget _lista() {
    return FutureBuilder(
        future: menuProvider.cargarData(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            children: _listaItems(snapshot.data, context),
          );
        });
  }

  List<Widget> _listaItems(List<dynamic>? data, BuildContext context) {
    final List<Widget> opciones = [];

    if (data != null) {
      data.forEach((opt) {
        final widget = ListTile(
            title: Text(opt['texto']),
            leading: getIcon(opt['icon']),
            onTap: () {
              // final route = MaterialPageRoute(
              // builder: (context){
              //   return AlertPage();
              // }
              // );
              // Navigator.push( context, route);
              Navigator.pushNamed(context, opt['ruta']);
            });
        opciones
          ..add(widget)
          ..add(Divider());
      });
    } else {
      return [];
    }

    return opciones;
  }
}
