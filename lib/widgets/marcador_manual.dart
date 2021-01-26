part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return _BuidlMarcadorManual();
        }
        return Container();
      },
    );
  }
}

class _BuidlMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final BusquedaBloc busquedaBloc = BlocProvider.of<BusquedaBloc>(context);

    return Stack(
      children: [
        // Boton regresar
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 1000),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  busquedaBloc.add(OnDesactivarMarcadorManual());
                },
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: BounceInDown(
              from: 200,
              child: Icon(
                Icons.location_on,
                size: 50,
              ),
            ),
          ),
        ),
        // Boton de confirmar destino
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            duration: Duration(seconds: 1),
            child: MaterialButton(
              color: Colors.black,
              elevation: 0,
              splashColor: Colors.transparent,
              shape: StadiumBorder(),
              child: Text(
                'Confirmar destino',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {

                  this.calcularDestino(context);

              },
              minWidth: width - 120,
            ),
          ),
        ),
      ],
    );
  }

  void calcularDestino(BuildContext context) async{

    final trafficService = new TrafficService();

    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = context.read<MapaBloc>().state.ubicacionCentral;
    

    final trafficResponse = await trafficService.getCoordsInicioYFin(inicio, destino);
    
    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;



    // Decodificar los puntos

    final points = Poly.Polyline.Decode(
      encodedString: geometry,
      precision: 6,
    );

    final temp = points;

  }
}
