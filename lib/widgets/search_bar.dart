part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (!state.seleccionManual) {
          return FadeInDown(
            duration: Duration(milliseconds: 500),
            child: this.buildSearchBar(context),
          );
        }
        return Container();
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final BusquedaBloc busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
    final MiUbicacionBloc miUbicacionBloc =
        BlocProvider.of<MiUbicacionBloc>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () async {
          final resultado = await showSearch(
            context: context,
            delegate: SearchDestionation(miUbicacionBloc.state.ubicacion),
          );
          this.retornoBusqueda(context, resultado);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: width,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            child: Text(
              '¿Dónde quiere ir?',
              style: TextStyle(color: Colors.black87),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> retornoBusqueda(
      BuildContext context, SearchResult result) async {
    final BusquedaBloc busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
    final MiUbicacionBloc ubicacionBloc =
        BlocProvider.of<MiUbicacionBloc>(context);
    final MapaBloc mapaBloc = BlocProvider.of<MapaBloc>(context);

    if (result.cancelo) {
      busquedaBloc.add(OnDesactivarMarcadorManual());
      return;
    }
    if (result.manual) {
      busquedaBloc.add(OnActivarMarcadorManual());
      return;
    }

    calculandoAlerta(context);
    // Calcular la ruta en base al valor result
    // if (result.manual == true) {
    //   busquedaBloc.add(OnActivarMarcadorManual());
    // } else if (result.cancelo) {
    //   busquedaBloc.add(OnDesactivarMarcadorManual());
    // }
    final trafficService = new TrafficService();

    final inicio = ubicacionBloc.state.ubicacion;
    final destino = result.position;

    final drivingResponse =
        await trafficService.getCoordsInicioYFin(inicio, destino);

    final geometry = drivingResponse.routes[0].geometry;
    final duracion = drivingResponse.routes[0].duration;
    final distancia = drivingResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> rutaCoords = points.decodedCoords
        .map(
          (point) => LatLng(point[0], point[1]),
        )
        .toList();
    mapaBloc.add(
      OnRutaInicioDestino(rutaCoords, distancia, duracion),
    );

    Navigator.of(context).pop();
  }
}
