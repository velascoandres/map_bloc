import 'package:flutter/material.dart';
import 'package:map_bloc/pages/acceso_gps_page.dart';
import 'package:map_bloc/pages/home_page.dart';
import 'package:map_bloc/pages/loading_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoadingPage(),
      routes: {
        'mapa': (_) => MapaPage(),
        'loading': (_) => LoadingPage(),
        'acceso_page': (_) => AccesoGpsPage(),
      },
    );
  }
}