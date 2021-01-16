import 'package:flutter/material.dart';
import 'package:map_bloc/helpers/helpers.dart';
import 'package:map_bloc/pages/acceso_gps_page.dart';
import 'package:map_bloc/pages/home_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async{
    // TODO: Permiso gps
    // TODO: Gps esta activo

    await Future.delayed(Duration(milliseconds: 2000));
    // Navigator.pushReplacement(
    //   context,
    //   navegarFadeIn(context, MapaPage()),
    // );
    // Navigator.pushReplacement(
    //   context,
    //   navegarFadeIn(context, AccesoGpsPage()),
    // );
    print('Loading page');
  }
}
