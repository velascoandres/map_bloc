import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_bloc/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  // Controlador del mapa
  GoogleMapController _mapController;

  // Polylines
  Polyline _miRuta = new Polyline(
    polylineId: PolylineId('mi_ruta'),
    color: Colors.black87,
    width: 4,
  );

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._mapController = controller;

      this._mapController.setMapStyle(jsonEncode(UBER_MAP_THEME));

      this.add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final camaraUpdate = CameraUpdate.newLatLng(destino);
    this._mapController?.animateCamera(camaraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    if (event is OnMapaListo) {
      yield MapaState().copyWith(mapaListo: true);
    }

    if (event is OnNuevaUbicacion) {
      List<LatLng> points = [
        ...this._miRuta.points,
        event.ubicacion,
      ];

      this._miRuta = this._miRuta.copyWith(
        pointsParam: points,
      );

      final currentPolylines = state.polylines;
      currentPolylines['mi_ruta'] = this._miRuta;

      yield MapaState().copyWith(
        polylines: currentPolylines,
      );
    }
  }
}
