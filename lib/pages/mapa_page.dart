import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_bloc/bloc/mapa/mapa_bloc.dart';
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
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: (_, state) => crearMapa(state),
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion)
      return Center(
        child: Text('Ubicando...'),
      );

    final camaraPosicion = new CameraPosition(
      target: state.ubicacion,
      zoom: 15,
    );


    final mapaBloc = context.read<MapaBloc>();

    // return Text('${state.ubicacion.latitude}, ${state.ubicacion.longitude}');

    return GoogleMap(
      initialCameraPosition: camaraPosicion,
      mapType: MapType.normal,
      compassEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: mapaBloc.initMapa,
    );
  }
}
