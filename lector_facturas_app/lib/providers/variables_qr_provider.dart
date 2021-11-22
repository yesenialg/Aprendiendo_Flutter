import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _VariableQRProvider {
  List<dynamic> opciones = [];
  List<dynamic> opc = [];

  _VariableQRProvider() {
    //cargarData();
  }

  //Retornar la indormación que esté adentro
  Future<List<dynamic>> cargarData(int index) async {
    final resp = await rootBundle.loadString('data/diccionario_qr.json');
    Map dataMap = json.decode(resp);
    //print(dataMap['variables']);
    opciones = dataMap['variables'];
    opc = (opciones[index]['sintaxis']);

    return opc;
  }
}

final variablesQrProvider = new _VariableQRProvider();
