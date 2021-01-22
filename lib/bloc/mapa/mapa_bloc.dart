import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';


import 'package:map_bloc/themes/uber_map_theme.dart';

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
    
      yield state.copyWith(mapaListo: true);
    
    } else if (event is OnNuevaUbicacion) {

      yield* this._onNuevaUbicacion(event);
    
    } else if (event is OnMarcarRecorrido) {
      
      yield* this._onMarcarRecorrido(event);

    }
  }



  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event) async* {

    final List<LatLng> points = [...this._miRuta.points, event.ubicacion];

    this._miRuta = this._miRuta.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;

    yield state.copyWith(polylines: currentPolylines);
  
  }


  Stream<MapaState>_onMarcarRecorrido(OnMarcarRecorrido event) async*{
    final bool nuevoValor = !state.dibujarRecorrido;
      Color colorRuta = nuevoValor ? Colors.black87 : Colors.transparent;

      this._miRuta = this._miRuta.copyWith(colorParam: colorRuta);

      final currentPolylines = state.polylines;
      currentPolylines['mi_ruta'] = this._miRuta;

      yield state.copyWith(
        dibujarRecorrido: !state.dibujarRecorrido,
        polylines: currentPolylines,
      );
  }
}
