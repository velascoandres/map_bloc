part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnNuevaUbicacion extends MapaEvent {
  final LatLng ubicacion;
  OnNuevaUbicacion(this.ubicacion);
}


class OnMarcarRecorrido extends MapaEvent {}
class OnSeguirUbicacion extends MapaEvent {}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;
  OnMovioMapa(this.centroMapa);
}


class OnRutaInicioDestino extends MapaEvent {
  final List<LatLng> rutaCoordenadas;
  final double distancia;
  final double duracion;


  OnRutaInicioDestino(this.rutaCoordenadas, this.distancia, this.duracion);
}
