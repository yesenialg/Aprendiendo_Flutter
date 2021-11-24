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
  TablePageState createState() => TablePageState();
}

class TablePageState extends State<TablePage> {
  String _range = '';
  String _start = '';
  String _end = '';
  String _opcionSeleccionada = 'Factura';
  List<String> _tipoQR = [
    'Factura',
    'Nota credito',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Text("Tabla"),
      ),
      body: _cargarScans(),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => mostrarCalendario(context),
            icon: const Icon(Icons.calendar_today),
            //label: 'Fecha',
          ),
          ActionButton(
            onPressed: () => mostrarTipos(context),
            //label: 'Tipo QR',
            icon: const Icon(Icons.merge_type),
          ),
          ActionButton(
            onPressed: () => _cargarScans(),
            icon: const Icon(Icons.cleaning_services),
            //label: 'Limpiar',
          ),
        ],
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

  void mostrarTipos(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Filtar por tipo de QR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      child: Container(
                          child: Positioned(
                        left: 0,
                        top: 80,
                        right: 0,
                        bottom: 0,
                        child: DropdownButton(
                            value: _opcionSeleccionada,
                            items: getOpcionesDropdown(),
                            onChanged: (opt) {
                              //print(opt);
                              setState(() {
                                _opcionSeleccionada = opt.toString();
                              });
                            }),
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
                    onPressed: () {
                      //print(EnlacesTable().scansFiltered[0]);
                    }),
              ]);
          ;
        });
  }

  void mostrarCalendario(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Filtar por rango de fecha',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                              onSelectionChanged: _onSelectionChanged,
                              selectionMode: DateRangePickerSelectionMode.range,
                              initialSelectedRange: PickerDateRange(
                                  DateTime.now()
                                      .subtract(const Duration(days: 4)),
                                  DateTime.now().add(const Duration(days: 3))),
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
                      }
                    }),
              ]);
          ;
        });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd-MM-yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd-MM-yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
        _start =
            DateFormat('dd-MM-yyyy').format(args.value.startDate).toString();

        _end = DateFormat('dd-MM-yyyy')
            .format(args.value.endDate ?? args.value.startDate)
            .toString();
        print('Range: $_range');
        print('Start: $_start');
        print('End: $_end');
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
