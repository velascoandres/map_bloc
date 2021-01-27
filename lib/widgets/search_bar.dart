part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (!state.seleccionManual) {
          return FadeInDown(
            duration: Duration(milliseconds: 500),
            child: this.buildSearchBar(context),
            );
        }
        return Container();
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final BusquedaBloc busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
    final MiUbicacionBloc miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () async {
          final resultado = await showSearch(
            context: context,
            delegate: SearchDestionation(miUbicacionBloc.state.ubicacion),
          );
          this.retornoBusqueda(context, resultado);

          //

          if (resultado.manual == true) {
            busquedaBloc.add(OnActivarMarcadorManual());
          } else if (resultado.cancelo) {
            busquedaBloc.add(OnDesactivarMarcadorManual());
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: width,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            child: Text(
              '¿Dónde quiere ir?',
              style: TextStyle(color: Colors.black87),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result) {
    if (result.cancelo) return;

    if (result.manual) {
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }
  }
}
