part of 'widgets.dart';

class BtnUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MapaBloc mapaBloc = context.watch<MapaBloc>();
    final LatLng destino = context.select(
      (MiUbicacionBloc miUbicacionBloc) => miUbicacionBloc.state.ubicacion,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
          onPressed: () {
            mapaBloc.moverCamara(destino);
          },
        ),
      ),
    );
  }
}
