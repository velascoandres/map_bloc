import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());


  StreamSubscription<Position> _positionSubscription;

  void iniciarSeguimiendo() async {
    // await Geolocator.isLocationServiceEnabled()

   this._positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10, // emita luego de 10 metros
    ).listen(
      (Position position) {
        print(position);
      },
    );
  }

  void cancelarSeguimiento(){
    _positionSubscription?.cancel();
  }


  @override
  Stream<MiUbicacionState> mapEventToState(
    MiUbicacionEvent event,
  ) async* {}
}
