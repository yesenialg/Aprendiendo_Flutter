import 'package:flutter/material.dart';
import 'package:lector_facturas_app/pages/home_page.dart';
import 'package:lector_facturas_app/pages/table_page.dart';
import 'package:lector_facturas_app/providers/scan_list_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => new ScanListProvider(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QR Reader',
          initialRoute: 'home',
          routes: {
            'home': (_) => HomePage(),
            'table': (_) => TablePage(),
          },
          theme: ThemeData(
              primaryColor: Colors.indigo,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.indigo)),
        ));
  }
}
