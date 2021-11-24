import 'dart:io';

import 'package:lector_facturas_app/models/scan_model.dart';
export 'package:lector_facturas_app/models/scan_model.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cufe TEXT NOT NULL,
            fecha TEXT NOT NULL,
            total DOUBLE NOT NULL,
            num_factura TEXT NOT NULL,
            establecimiento TEXT,
            tipo TEXT,
            doc TEXT
          )
        ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final cufe = nuevoScan.cufe;
    final fecha = nuevoScan.fecha;
    final total = nuevoScan.total;
    final num_factura = nuevoScan.num_factura;
    final doc = nuevoScan.doc;
    final establecimiento = nuevoScan.establecimiento;
    final tipo= nuevoScan.tipo;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(cufe, fecha, total, num_factura, establecimiento,tipo, doc)
      VALUES ('$cufe', '$fecha', '$total', '$num_factura', '$establecimiento', '$tipo','$doc')
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScanByCufe(String cufe) async {
    final db = await database;
    final res = await db.query('Scans', where: 'cufe = ?', whereArgs: [cufe]);
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  // Future<ScanModel?> getScanById(int id) async {
  //   final db = await database;
  //   final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

  //   return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  // }

  Future<List<ScanModel>> getTodoslosScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id=?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }
}
