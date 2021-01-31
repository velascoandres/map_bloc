part of 'helpers.dart';


Future<BitmapDescriptor> getMarkerInicioIcon(int segundos) async{
  final recorder = new PictureRecorder();
  final canvas = new Canvas(recorder);

  final size = new Size(350, 150);

  final minutos = (segundos / 60).floor();

  final markerInicio = new MarkerInicioPainter(minutos);
  markerInicio.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(
    byteData.buffer.asUint8List()
  );

}
