import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsPage extends StatefulWidget {
  const AccesoGpsPage({Key key}) : super(key: key);

  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>
    with WidgetsBindingObserver {
  bool activoGps = true;

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
      if (tienePermiso) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el GPS para usar esta app'),
            FutureBuilder(
              future: geo.Geolocator.isLocationServiceEnabled(),
              builder: (_, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData && snapshot.data) {
                  return MaterialButton(
                    child: Text(
                      'Solicitar Acceso',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                    shape: StadiumBorder(),
                    elevation: 0,
                    splashColor: Colors.transparent,
                    onPressed: () async {
                      final status = await Permission.location.request();
                      this.accesoGps(status);
                    },
                  );
                }
                return Text('Active GPS');
              },
            ),
          ],
        ),
      ),
    );
  }

  void accesoGps(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
