import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {



  MapaBloc() : super(MapaState());

  GoogleMapController _mapController;


  void initMapa(GoogleMapController controller){
      if(!state.mapaListo){
        this._mapController = controller;

        // TODO: Cambiar el estilo del mapa

        add(OnMapaListo());

      }
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
