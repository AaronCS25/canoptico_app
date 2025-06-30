import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:canoptico_app/features/dashboard/dashboard.dart';

part 'live_camera_state.dart';

class LiveCameraCubit extends Cubit<LiveCameraState> {
  final CameraStreamRepository _cameraRepository;
  StreamSubscription? _cameraSubscription;

  LiveCameraCubit(this._cameraRepository) : super(const LiveCameraState());

  void startStreaming() {
    if (state.status == CameraStatus.live ||
        state.status == CameraStatus.connecting) {
      return;
    }

    emit(state.copyWith(status: CameraStatus.connecting));
    _cameraSubscription = _cameraRepository.getFrameStream().listen(
      (frame) {
        emit(state.copyWith(status: CameraStatus.live, currentFrame: frame));
      },
      onError: (error) {
        emit(state.copyWith(status: CameraStatus.error));
      },
      onDone: () {
        emit(state.copyWith(status: CameraStatus.inactive));
      },
    );
  }

  void stopStreaming() {
    _cameraSubscription?.cancel();
    _cameraSubscription = null;
    _cameraRepository.dispose();
    emit(state.copyWith(status: CameraStatus.inactive));
  }

  @override
  Future<void> close() {
    stopStreaming();
    return super.close();
  }
}
