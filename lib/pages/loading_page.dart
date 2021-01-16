import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_bloc/helpers/helpers.dart';
import 'package:map_bloc/pages/acceso_gps_page.dart';
import 'package:map_bloc/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> checkGpsLocation(BuildContext context) async {
    // Permiso gps
    final permisoGps = await Permission.location.isGranted;

    // Gps esta activo
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if (permisoGps && gpsActivo) {
      Navigator.pushReplacement(
        context,
        navegarFadeIn(context, MapaPage()),
      );
      return '';
    } else if (!permisoGps) {
      Navigator.pushReplacement(
        context,
        navegarFadeIn(context, AccesoGpsPage()),
      );
      return 'Es necesario el permiso de GPS';
    } else {
      return 'Active el GPS';
    }
  }
}
