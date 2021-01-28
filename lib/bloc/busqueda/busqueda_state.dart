part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {
  final bool seleccionManual;
  final List<SearchResult> historial;

  BusquedaState({
    this.seleccionManual = false,
    List<SearchResult> historial = null,
  }) : this.historial = historial ?? [];

  BusquedaState copyWith({
    bool seleccionManual,
    List<SearchResult> historial,
  }) {
    return BusquedaState(
      seleccionManual: seleccionManual ?? this.seleccionManual,
      historial: historial ?? this.historial,
    );
  }
}
