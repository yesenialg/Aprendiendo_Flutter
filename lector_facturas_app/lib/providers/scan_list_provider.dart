import 'package:flutter/material.dart';
import 'package:lector_facturas_app/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans = [];

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScanRaw(nuevoScan);
    nuevoScan.id = id;

    this.scans.add(nuevoScan);
    notifyListeners();

    return nuevoScan;
  }

  cargarScans() async {
    final Scans = await DBProvider.db.getTodoslosScans();
    this.scans = [...Scans];
    notifyListeners();
  }

  borrarScans() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }
  
  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    this.cargarScans();
  }
}