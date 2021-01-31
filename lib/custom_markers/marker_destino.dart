import 'package:flutter/material.dart';

class MarkerDestinoPainter extends CustomPainter {
  final String descripcion;
  final double metros;

  MarkerDestinoPainter(this.descripcion, this.metros);

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
    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);
    canvas.drawShadow(
      path,
      Colors.black87,
      10,
      false,
    );

    // Caja Blanca
    final cajaBlanca = Rect.fromLTWH(0, 20, size.width - 10, 80);
    canvas.drawRect(cajaBlanca, paint);

    // Caja Negra
    paint.color = Colors.black87;
    final cajaNegra = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    // Dibujar textos
    // Kilometros
    double kilometros = this.metros / 1000;  
    kilometros = (kilometros * 100).floor().toDouble();
    kilometros = kilometros / 100;
    TextSpan textSpan = new TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      text: '$kilometros',
    );
    TextPainter textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: 70,
        minWidth: 70,
      );
    textPainter.paint(canvas, Offset(0, 35));
    // Minutos
    textSpan = new TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      text: 'Km',
    );
    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: 70,
        minWidth: 70
      );
    textPainter.paint(canvas, Offset(0, 67));

    // Mi ubicacion
    textSpan = new TextSpan(
      style: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      text: '$descripcion',
    );
    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...'
    )..layout(
        maxWidth: size.width - 100,
      );
    textPainter.paint(canvas, Offset(90, 35));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
