import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_bloc/helpers/helpers.dart';
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

  Polyline _miRutaDestino = new Polyline(
    polylineId: PolylineId('mi_ruta_destino'),
    color: Colors.yellowAccent,
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
    } else if (event is OnSeguirUbicacion) {
      yield* this._onSeguirUbicacion(event);
    } else if (event is OnMovioMapa) {
      yield* this._onMovioMapa(event);
    } else if (event is OnRutaInicioDestino) {
      yield* this._onRutaInicioDestino(event);
    }
  }

  Stream<MapaState> _onRutaInicioDestino(OnRutaInicioDestino event) async* {
    this._miRutaDestino = this._miRutaDestino.copyWith(
          pointsParam: event.rutaCoordenadas,
        );

    print(event.rutaCoordenadas);
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta_destino'] = this._miRutaDestino;

    // Icono Inicio

    final iconoInicio = await getAssetImageMarker();
    final iconoDestino = await getNetworkImageMarker();

    // Marcadores
    final markerInicio = new Marker(
      markerId: MarkerId('inicio'),
      position: event.rutaCoordenadas[0],
      icon: iconoInicio,
      infoWindow: InfoWindow(
        title: 'Tu origen',
        snippet: 'Duración recorrido: ${(event.duracion / 60).floor()} minutos',
        onTap: (){},
        anchor: Offset(0.5, 0),
      ),
    );
    final ultimoIndice = event.rutaCoordenadas.length - 1;
    // marcador destino
    double kilometros = (event.distancia / 10).floor().toDouble()/ 100;
    
    
    final markerDestino = new Marker(
      markerId: MarkerId('destino'),
      position: event.rutaCoordenadas[ultimoIndice],
      icon: iconoDestino,
      infoWindow: InfoWindow(
        title: event.nombreDestino,
        snippet: 'Distancia: $kilometros Kilómetros'
      ),
    );

    final nuevosMarcadores = {...state.markers};
    nuevosMarcadores['inicio'] = markerInicio;
    nuevosMarcadores['destino'] = markerDestino;

    yield state.copyWith(
      polylines: currentPolylines,
      markers: nuevosMarcadores,
    );
  }

  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event) async* {
    final List<LatLng> points = [...this._miRuta.points, event.ubicacion];

    this._miRuta = this._miRuta.copyWith(pointsParam: points);

    if (state.seguirUbicacion) {
      this.moverCamara(event.ubicacion);
    }

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;

    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
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

  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event) async* {
    final bool nuevoValor = !state.seguirUbicacion;

    if (nuevoValor) {
      this.moverCamara(this._miRuta.points[this._miRuta.points.length - 1]);
    }

    yield state.copyWith(
      seguirUbicacion: nuevoValor,
    );
  }

  Stream<MapaState> _onMovioMapa(OnMovioMapa event) async* {
    yield state.copyWith(
      ubicacionCentral: event.centroMapa,
    );
  }
}
