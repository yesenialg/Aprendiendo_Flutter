import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:lector_facturas_app/pages/historial_enlaces.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:lector_facturas_app/widgets/history_button.dart';
import 'package:lector_facturas_app/widgets/scan_button.dart';
import 'package:provider/provider.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              ArtDialogResponse response = await ArtSweetAlert.show(
                  barrierDismissible: false,
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    denyButtonText: "Cancelar",
                    title: "¿Quieres eliminar todos los registros?",
                    confirmButtonText: "Eliminar",
                  ));

              if (response.isTapConfirmButton) {
                Provider.of<ScanListProvider>(context, listen: false)
                    .borrarScans();
                ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                        type: ArtSweetAlertType.success, title: "Eliminados!"));
                return;
              }

              if (response.isTapDenyButton) {
                return;
              }
            },
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _cargarScans(),
      //bottomNavigationBar: CustomNavigatorBar(),
      floatingActionButton:_crearBotones(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //bottomNavigationBar: ,
    );
  }
}

  Widget _crearBotones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        SizedBox(width: 200,height: 100),
        ScanButton(),
        Expanded(child: SizedBox()),
        HistoryButton(),
      ],
    );
  }

class _cargarScans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    scanListProvider.cargarScans();

    return EnlacesPage();
  }
}