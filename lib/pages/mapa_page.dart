import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_bloc/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';


class MapaPage extends StatefulWidget {
  const MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    
    context.read<MiUbicacionBloc>().iniciarSeguimiendo();
    
    super.initState();
  }

  @override
  void dispose() {
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Mapa Page'),
      ),
    );
  }
}
