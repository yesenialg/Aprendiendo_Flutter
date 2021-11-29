import 'package:flutter/material.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

class EnlacesTable extends StatefulWidget {
  @override
  _EnlacesTableState createState() => _EnlacesTableState();
}

class _EnlacesTableState extends State<EnlacesTable> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late ScanListProvider scanListProvider;
  late List _scans;
  List scansFiltered = [];
  @override
  Widget build(BuildContext context) {
    scanListProvider = Provider.of<ScanListProvider>(context);
    _scans = scanListProvider.scans;
    //var sc = <ScanModel>[];

    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
              sortColumnIndex: _currentSortColumn,
              sortAscending: _isAscending,
              dataRowColor: MaterialStateProperty.all(Colors.indigo[50]),
              headingRowColor: MaterialStateProperty.all(Colors.indigo[100]),

              //minWidth: 600,
              columns: [
                DataColumn(
                    label: Text('ID',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold)),
                    numeric: true,
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (_isAscending) {
                          _isAscending = false;
                          _scans.sort((a, b) => a.id.compareTo(b.id));
                        } else {
                          _isAscending = true;
                          _scans.sort((a, b) => b.id.compareTo(a.id));
                        }
                      });
                    }),
                DataColumn(
                    label: Text('FECHA',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold)),
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (_isAscending) {
                          _isAscending = false;
                          _scans.sort((a, b) => a.fecha.compareTo(b.fecha));
                        } else {
                          _isAscending = true;
                          _scans.sort((a, b) => b.fecha.compareTo(a.fecha));
                        }
                      });
                    }),
                DataColumn(
                    label: Text('TOTAL',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold)),
                    numeric: true,
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (_isAscending) {
                          _isAscending = false;
                          _scans.sort((a, b) => a.total.compareTo(b.total));
                        } else {
                          _isAscending = true;
                          _scans.sort((a, b) => b.total.compareTo(a.total));
                        }
                      });
                    }),
                DataColumn(
                    label: Text('FACTURA',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold)),
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (_isAscending) {
                          _isAscending = false;
                          _scans.sort(
                              (a, b) => a.num_factura.compareTo(b.num_factura));
                        } else {
                          _isAscending = true;
                          _scans.sort(
                              (a, b) => b.num_factura.compareTo(a.num_factura));
                        }
                      });
                    }),
                DataColumn(
                    label: Text('ESTABLECIMIENTO',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold)),
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (_isAscending) {
                          _isAscending = false;
                          _scans.sort((a, b) =>
                              a.establecimiento.compareTo(b.establecimiento));
                        } else {
                          _isAscending = true;
                          _scans.sort((a, b) =>
                              b.establecimiento.compareTo(a.establecimiento));
                        }
                      });
                    }),
                DataColumn(
                    label: Text('TIPO',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold)),
                    onSort: (columnIndex, _) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        if (_isAscending) {
                          _isAscending = false;
                          _scans.sort((a, b) => a.tipo.compareTo(b.tipo));
                        } else {
                          _isAscending = true;
                          _scans.sort((a, b) => b.tipo.compareTo(a.tipo));
                        }
                      });
                    }),
              ],
              rows: _scans
                  .map((factura) =>
                      DataRow(selected: _scans.contains(factura), cells: [
                        DataCell(
                          Text(factura.id.toString()),
                          onTap: () {
                            // write your code..
                          },
                        ),
                        DataCell(Text(factura.fecha)),
                        DataCell(Text(factura.total.toString())),
                        DataCell(Text(factura.num_factura)),
                        DataCell(Text(factura.establecimiento)),
                        DataCell(Text(factura.tipo)),
                      ]))
                  .toList()),
        ),
      ),
    );
  }

  onSortColum(String variable) {
    scansFiltered =
        _scans.where((scan) => scan.tipo.contains(variable)).toList();
    for (var i = 0; i < scansFiltered.length; i++) {
      print(scansFiltered[i]);
    }
  }
}
