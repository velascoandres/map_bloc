import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_bloc/models/geocoding_response.dart' as GeoModel;
import 'package:map_bloc/models/search_result.dart';
import 'package:map_bloc/services/traffic_service.dart';

class SearchDestionation extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;

  SearchDestionation(this.proximidad)
      : this.searchFieldLabel = 'Buscar',
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cleaning_services),
        onPressed: () => this.query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final searchResult = SearchResult(cancelo: true);

    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => this.close(context, searchResult),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return this._construirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar ubicación manualmente'),
            onTap: () {
              this.close(
                context,
                SearchResult(cancelo: false, manual: true),
              );
            },
          ),
        ],
      );
    }
    return this._construirResultadosSugerencias();
  }

  Widget _construirResultadosSugerencias() {
    if (this.query.length == 0) {
      return Container();
    }

    this._trafficService.getSugerenciasPorQuery(this.query.trim(), proximidad);

    return StreamBuilder(
      stream: this._trafficService.sugerenciasStream,
      builder: (BuildContext context,
          AsyncSnapshot<GeoModel.GeocodingResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final lugares = snapshot.data.features;

        if (lugares.length > 0) {
          return ListView.separated(
            itemCount: lugares.length,
            separatorBuilder: (_, i) => Divider(),
            itemBuilder: (_, i) {
              final lugar = lugares[i];
              return ListTile(
                leading: Icon(Icons.place),
                title: Text(lugar.textEs),
                subtitle: Text(lugar.placeNameEs),
                onTap: () {
                  this.close(
                    context,
                    SearchResult(
                      cancelo: false,
                      manual: false,
                      position: LatLng(lugar.center[1], lugar.center[0]),
                      nombreDestino: lugar.textEs,
                      descripcion: lugar.placeNameEs,
                    ),
                  );
                },
              );
            },
          );
        } else {
          return ListTile(
            leading: Icon(Icons.sentiment_dissatisfied),
            title: Text('No hay resultados con $query'),
            subtitle: Text('Prueba con otra busqueda'),
            onTap: () {},
          );
        }
      },
    );
  }
}
