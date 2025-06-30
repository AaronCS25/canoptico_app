import 'dart:typed_data';

abstract class CameraStreamDatasource {
  Stream<Uint8List> getFrameStream();

  void dispose();
}
