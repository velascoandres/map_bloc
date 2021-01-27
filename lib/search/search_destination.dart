import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
        icon: Icon(Icons.clear),
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
    this._trafficService.obtenerDirecciones(this.query.trim(), this.proximidad);

    return Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
}
