import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_bloc/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {



  MapaBloc() : super(MapaState());

  GoogleMapController _mapController;


  void initMapa(GoogleMapController controller){
      if(!state.mapaListo){
        this._mapController = controller;

        this._mapController.setMapStyle(
          jsonEncode(UBER_MAP_THEME)
        );

        add(OnMapaListo());

      }
  }


  void moverCamara(LatLng destino){
      final camaraUpdate = CameraUpdate.newLatLng(destino);
      this._mapController?.animateCamera(camaraUpdate);
  }


  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {


      if(event is OnMapaListo){
        yield MapaState().copyWith(mapaListo: true);
      }
  }
}
