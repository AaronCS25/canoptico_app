import 'dart:typed_data';

import 'package:canoptico_app/features/dashboard/dashboard.dart';

class CameraStreamRepositoryImpl implements CameraStreamRepository {
  final CameraStreamDatasource datasource;

  CameraStreamRepositoryImpl(this.datasource);

  @override
  Stream<Uint8List> getFrameStream() {
    return datasource.getFrameStream();
  }

  @override
  void dispose() {
    datasource.dispose();
  }
}
