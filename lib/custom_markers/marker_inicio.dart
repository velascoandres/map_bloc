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
    // Sombra
    final path = new Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(
      path,
      Colors.black87,
      10,
      false,
    );

    // Caja Blanca
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 55, 80);
    canvas.drawRect(cajaBlanca, paint);

    // Caja Negra
    paint.color = Colors.black87;
    final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
