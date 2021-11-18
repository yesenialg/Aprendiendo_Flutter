import 'package:flutter/material.dart';
import 'package:lector_facturas_app/models/scan_model.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

class EnlacesTable extends StatefulWidget {
  @override
  _EnlacesTableState createState() => _EnlacesTableState();
}

class _EnlacesTableState extends State<EnlacesTable> {
  @override
  Widget build(BuildContext context) {
    ScanListProvider scanListProvider = Provider.of<ScanListProvider>(context);
    List scans = scanListProvider.scans;
    var sc = <ScanModel>[];

    var _chosenSubCounty='Mvita';
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            /*DropdownButton<String>(
                  value: _chosenSubCounty,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),

                  items: <String>['Mvita', 'Tudor', 'Kisauni'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Sub-County",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (String? value) {
                      setState(() {
                        _chosenSubCounty = value!;
                        scans = scans.where((element) => element.sub_county.contains(_chosenSubCounty)).toList();
                        
                      });
                    },
                  
                ),*/
            
            DataTable(
                sortColumnIndex: 1,
                columnSpacing: 35.0,
                horizontalMargin: 12,
                //minWidth: 600,
                columns: _HeaderTable,
                rows: scans
                    .map((factura) => DataRow(cells: [
                          DataCell(Text(factura.id.toString())),
                          DataCell(Text(factura.fecha)),
                          DataCell(Text(factura.total.toString())),
                          DataCell(Text(factura.num_factura)),
                          DataCell(Text(factura.establecimiento)),
                        ]))
                    .toList()),
          ],
        ),
      ),
    );
  }

  List<DataColumn> get _HeaderTable {
    return [
                DataColumn(
                  label: Text('ID'),
                ),
                DataColumn(
                  label: Text('FECHA'),
                ),
                DataColumn(
                  label: Text('TOTAL'),
                ),
                DataColumn(
                  label: Text('NRO FACTURA'),
                ),
                DataColumn(
                  label: Text('ESTABLECIMIENTO'),
                  numeric: true,
                ),
              ];
  }
}
