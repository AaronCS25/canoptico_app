import 'dart:async';
import 'dart:typed_data';
import 'package:canoptico_app/config/config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:canoptico_app/features/dashboard/dashboard.dart';

class RailwayCameraStreamDatasource implements CameraStreamDatasource {
  WebSocketChannel? _channel;
  StreamController<Uint8List>? _controller;

  @override
  Stream<Uint8List> getFrameStream() {
    _controller = StreamController<Uint8List>.broadcast();

    final uri = Uri.parse(
      "${Environment.apiUrl.replaceFirst('https://', 'wss://')}/video/ws",
    );

    _channel = WebSocketChannel.connect(uri);

    _channel!.stream.listen(
      (data) {
        if (data is List<int>) {
          _controller?.add(Uint8List.fromList(data));
        }
      },
      onDone: () => _controller?.close(),
      onError: (error) {
        print("WebSocket error: $error");
        _controller?.addError(error);
      },
    );
    return _controller!.stream;
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _controller?.close();
  }
}
