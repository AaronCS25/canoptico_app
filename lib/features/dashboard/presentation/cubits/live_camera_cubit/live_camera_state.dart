part of 'live_camera_cubit.dart';

enum CameraStatus { inactive, connecting, live, error }

class LiveCameraState extends Equatable {
  final CameraStatus status;
  final Uint8List? currentFrame;

  const LiveCameraState({
    this.status = CameraStatus.inactive,
    this.currentFrame,
  });

  LiveCameraState copyWith({
    CameraStatus? status,
    Uint8List? currentFrame,
  }) =>
      LiveCameraState(
        status: status ?? this.status,
        currentFrame: currentFrame ?? this.currentFrame,
      );

  @override
  List<Object?> get props => [status, currentFrame];
}