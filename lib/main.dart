import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_bloc/bloc/busqueda/busqueda_bloc.dart';
import 'package:map_bloc/bloc/mapa/mapa_bloc.dart';
import 'package:map_bloc/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:map_bloc/pages/acceso_gps_page.dart';
import 'package:map_bloc/pages/mapa_page.dart';
import 'package:map_bloc/pages/loading_page.dart';
import 'package:map_bloc/pages/test_marker_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => MiUbicacionBloc(),),
        BlocProvider(create: ( _ ) => MapaBloc(),),
        BlocProvider(create: ( _ ) => BusquedaBloc(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: TestMarkerPage(),
        routes: {
          'mapa': (_) => MapaPage(),
          'loading': (_) => LoadingPage(),
          'acceso_page': (_) => AccesoGpsPage(),
          'test-marker': (_) => TestMarkerPage(),
        },
      ),
    );
  }
}
