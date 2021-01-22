part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng ubicacionCentral;
  // Polyline
  final Map<String, Polyline> polylines;

  MapaState({
    this.seguirUbicacion = false,
    this.mapaListo = false,
    this.dibujarRecorrido = true,
    this.ubicacionCentral = null,
    final Map<String, Polyline> polylines,
  }) : this.polylines = polylines ?? new Map();

  MapaState copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    bool seguirUbicacion,
    LatLng ubicacionCentral,
    Map<String, Polyline> polylines,
  }) {
    return MapaState(
      mapaListo: mapaListo ?? this.mapaListo,
      dibujarRecorrido: dibujarRecorrido  ?? this.dibujarRecorrido,
      seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
      ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
      polylines: polylines ?? this.polylines,
    );
  }
}
