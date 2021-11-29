import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:lector_facturas_app/pages/table_enlaces.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/widgets/filter_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TablePage extends StatefulWidget {
  TablePage({Key? key}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  TextEditingController controller = TextEditingController();
  String _searchResult = '';

  String _range = '';
  String _start = '';
  String _end = '';
  String _opcionSeleccionada = 'Factura';
  final List<String> _tipoQR = [
    'Factura',
    'Nota credito',
  ];
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late ScanListProvider scanListProvider;
  late List _scans;
  List scansFiltered = [];

  bool _checkConfiguration() => true;

  @override
  void didChangeDependencies() {
    if (_checkConfiguration()) {
      scanListProvider = Provider.of<ScanListProvider>(context);
      _scans = scanListProvider.scans;
      scansFiltered = _scans;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 0,
          title: Text("Tabla"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal:10.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Buscar', border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {
                          _searchResult = value;
                          scansFiltered = _scans
                              .where((scan) =>
                                  scan.tipo.contains(_searchResult) ||
                                  scan.establecimiento.contains(_searchResult) ||
                                  scan.fecha.contains(_searchResult) ||
                                  scan.total.toString().contains(_searchResult) ||
                                  scan.id.toString().contains(_searchResult) ||
                                  scan.num_factura.contains(_searchResult))
                              .toList();
                        });
                      }),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        controller.clear();
                        _searchResult = '';
                        scansFiltered = _scans;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                      sortColumnIndex: _currentSortColumn,
                      sortAscending: _isAscending,
                      dataRowColor:
                          MaterialStateProperty.all(Colors.indigo[50]),
                      headingRowColor:
                          MaterialStateProperty.all(Colors.indigo[100]),

                      //minWidth: 600,
                      columns: [
                        DataColumn(
                            label: Text('ID',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold)),
                            numeric: true,
                            onSort: (columnIndex, _) {
                              setState(() {
                                _currentSortColumn = columnIndex;
                                if (_isAscending) {
                                  _isAscending = false;
                                  scansFiltered
                                      .sort((a, b) => a.id.compareTo(b.id));
                                } else {
                                  _isAscending = true;
                                  scansFiltered
                                      .sort((a, b) => b.id.compareTo(a.id));
                                }
                              });
                            }),
                        DataColumn(
                            label: Text('FECHA',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold)),
                            onSort: (columnIndex, _) {
                              setState(() {
                                _currentSortColumn = columnIndex;
                                if (_isAscending) {
                                  _isAscending = false;
                                  scansFiltered.sort(
                                      (a, b) => a.fecha.compareTo(b.fecha));
                                } else {
                                  _isAscending = true;
                                  scansFiltered.sort(
                                      (a, b) => b.fecha.compareTo(a.fecha));
                                }
                              });
                            }),
                        DataColumn(
                            label: Text('TOTAL',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold)),
                            numeric: true,
                            onSort: (columnIndex, _) {
                              setState(() {
                                _currentSortColumn = columnIndex;
                                if (_isAscending) {
                                  _isAscending = false;
                                  scansFiltered.sort(
                                      (a, b) => a.total.compareTo(b.total));
                                } else {
                                  _isAscending = true;
                                  scansFiltered.sort(
                                      (a, b) => b.total.compareTo(a.total));
                                }
                              });
                            }),
                        DataColumn(
                            label: Text('FACTURA',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold)),
                            onSort: (columnIndex, _) {
                              setState(() {
                                _currentSortColumn = columnIndex;
                                if (_isAscending) {
                                  _isAscending = false;
                                  scansFiltered.sort((a, b) =>
                                      a.num_factura.compareTo(b.num_factura));
                                } else {
                                  _isAscending = true;
                                  scansFiltered.sort((a, b) =>
                                      b.num_factura.compareTo(a.num_factura));
                                }
                              });
                            }),
                        DataColumn(
                            label: Text('ESTABLECIMIENTO',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold)),
                            onSort: (columnIndex, _) {
                              setState(() {
                                _currentSortColumn = columnIndex;
                                if (_isAscending) {
                                  _isAscending = false;
                                  scansFiltered.sort((a, b) => a.establecimiento
                                      .compareTo(b.establecimiento));
                                } else {
                                  _isAscending = true;
                                  scansFiltered.sort((a, b) => b.establecimiento
                                      .compareTo(a.establecimiento));
                                }
                              });
                            }),
                        DataColumn(
                            label: Text('TIPO',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold)),
                            onSort: (columnIndex, _) {
                              setState(() {
                                _currentSortColumn = columnIndex;
                                if (_isAscending) {
                                  _isAscending = false;
                                  scansFiltered
                                      .sort((a, b) => a.tipo.compareTo(b.tipo));
                                } else {
                                  _isAscending = true;
                                  scansFiltered
                                      .sort((a, b) => b.tipo.compareTo(a.tipo));
                                }
                              });
                            }),
                      ],
                      rows: scansFiltered
                          .map((factura) => DataRow(
                                  selected: scansFiltered.contains(factura),
                                  cells: [
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
            ),
          ],
        ),
        floatingActionButton: ExpandableFab(
          distance: 112.0,
          children: [
            ActionButton(
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 20),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Filtar por rango de fecha',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                  width: 400.0,
                                  height: 400.0,
                                  child: Container(
                                      height: 250,
                                      child: Positioned(
                                        left: 0,
                                        top: 80,
                                        right: 0,
                                        bottom: 0,
                                        child: SfDateRangePicker(
                                          onSelectionChanged:
                                              _onSelectionChanged,
                                          selectionMode:
                                              DateRangePickerSelectionMode
                                                  .range,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                                child: Text('Cancelar'),
                                onPressed: () => Navigator.of(context).pop()),
                            TextButton(
                                child: Text('Filtrar'),
                                onPressed: () async {
                                  if (_start == _end) {
                                    ArtSweetAlert.show(
                                        context: context,
                                        artDialogArgs: ArtDialogArgs(
                                            type: ArtSweetAlertType.danger,
                                            title:
                                                "Debe seleccioanr un rango de fecha valido"));
                                  } else {
                                    //var parsedDate = DateTime.parse('1974-03-20 00:00:00.000');
                                    List datos = [];
                                    setState(() {
                                      
                                      _searchResult = _opcionSeleccionada;
                                      //scansFiltered.clear();
                                      //scansFiltered = _scans.where((scan) =>scan.tipo.contains(_searchResult)).toList();
                                      DateTime inicio = DateFormat("yyyy-MM-dd")
                                          .parse(_start);
                                      DateTime fin =
                                          DateFormat("yyyy-MM-dd").parse(_end);

                                      for (int j = 0; j < _scans.length; j++) {
                                        DateTime dato = DateFormat("yyyy-MM-dd")
                                            .parse(_scans[j].fecha);
                                        if (dato.isAfter(inicio) &&
                                            dato.isBefore(fin)) {
                                          datos.add(_scans[j]);
                                        }
                                        //datos.add(_scans[j]);
                                      }
                                    });
                                    scansFiltered = datos;
                                    Navigator.of(context).pop();
                                  }
                                }),
                          ])),
              icon: const Icon(Icons.calendar_today),
              //label: 'Fecha',
            ),
            ActionButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Filtar por tipo de QR'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: <Widget>[
                          DropdownButton(
                              value: _opcionSeleccionada,
                              items: getOpcionesDropdown(),
                              onChanged: (opt) {
                                print(opt);
                                setState(() {
                                  _opcionSeleccionada = opt.toString();
                                });
                              })
                        ],
                      )
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancelar'),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => {
                        setState(() {
                          _searchResult = _opcionSeleccionada;
                          scansFiltered = _scans
                              .where(
                                  (scan) => scan.tipo.contains(_searchResult))
                              .toList();
                        }),
                        Navigator.pop(context, 'Filtar'),
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              //mostrarTipos(context),
              //label: 'Tipo QR',
              icon: const Icon(Icons.merge_type),
            ),
            ActionButton(
              onPressed: () => {
                {
                  setState(() {
                    controller.clear();
                    _searchResult = '';
                    scansFiltered = _scans;
                  })
                }
              },
              icon: const Icon(Icons.cleaning_services),
              //label: 'Limpiar',
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];

    _tipoQR.forEach((tipo) {
      lista.add(DropdownMenuItem(child: Text(tipo), value: tipo));
    });

    return lista;
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('yyyy-MM-dd').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('yyyy-MM-dd')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
        _start =
            DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();

        _end = DateFormat('yyyy-MM-dd')
            .format(args.value.endDate ?? args.value.startDate)
            .toString();
        print('Range: $_range');
        //print('Start: $_start');
        //print('End: $_end');
      } /* else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      } */
    });
  }
}

//EnlacesTable(),
class _cargarScans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    scanListProvider.cargarScans();

    return EnlacesTable();
  }
}
