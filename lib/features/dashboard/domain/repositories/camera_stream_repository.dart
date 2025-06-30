import 'dart:typed_data';

abstract class CameraStreamRepository {
  Stream<Uint8List> getFrameStream();

  void dispose();
}
