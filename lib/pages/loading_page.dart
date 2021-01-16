import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_bloc/helpers/helpers.dart';
import 'package:map_bloc/pages/acceso_gps_page.dart';
import 'package:map_bloc/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final tienePermiso = await Permission.location.isGranted;
      final gpsActivo = await Geolocator.isLocationServiceEnabled();


      print(tienePermiso);
      print(gpsActivo);


      if (tienePermiso && gpsActivo) {
        Navigator.pushReplacement(
          context,
          navegarFadeIn(context, MapaPage()),
        );
      }
    }
  }

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
