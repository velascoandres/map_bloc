import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_bloc/bloc/mapa/mapa_bloc.dart';
import 'package:map_bloc/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:map_bloc/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  LatLng ultimaPosicion;

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
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (_, state) => crearMapa(state),
          ),
          Positioned(
            top: 10,
            child: SearchBar(),
          ),
          MarcadorManual(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnMiRuta(),
          BtnSeguirUbicacion(),
        ],
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

    mapaBloc.add(
      OnNuevaUbicacion(
        state.ubicacion,
      ),
    );

    // return Text('${state.ubicacion.latitude}, ${state.ubicacion.longitude}');

    return GoogleMap(
      initialCameraPosition: camaraPosicion,
      mapType: MapType.normal,
      compassEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: mapaBloc.initMapa,
      polylines: mapaBloc.state.polylines.values.toSet(),
      onCameraMove: (CameraPosition position) {
        this.ultimaPosicion = position.target;
      },
      onCameraIdle: () {
        mapaBloc.add(OnMovioMapa(this.ultimaPosicion));
      },
    );
  }
}
