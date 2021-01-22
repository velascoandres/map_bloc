part of 'widgets.dart';

class BtnSeguirUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
        final bool seguirUbicacion = state.seguirUbicacion;

        final icono =
            seguirUbicacion ? Icons.directions_run : Icons.accessibility_new;

        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(
                icono,
                color: Colors.black87,
              ),
              onPressed: () {
                context.read<MapaBloc>().add(OnSeguirUbicacion());
              },
            ),
          ),
        );
      },
    );
  }
}
