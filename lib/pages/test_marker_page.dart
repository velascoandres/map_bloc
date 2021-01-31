import 'package:flutter/material.dart';
import 'package:map_bloc/custom_markers/custom_markers.dart';

class TestMarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            painter: MarkerDestinoPainter(
              'Mi destino es asdasd adas asdas ada la casita es linda asadsd asa ',
              350904,
            ),
          ),
        ),
      ),
    );
  }
}
