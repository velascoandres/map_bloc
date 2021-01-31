import 'package:flutter/material.dart';

class MarkerInicioPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()..color = Colors.black;
    // Dibujar circulo negro
    final double circuloNegroR = 20;
    
    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR),
      circuloNegroR,
      paint,
    );

    // Circulo Blanco
    paint.color = Colors.white;
    final double ciculoBlancoR = 5;
    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR),
      ciculoBlancoR,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
