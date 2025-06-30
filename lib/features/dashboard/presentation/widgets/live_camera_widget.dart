import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/dashboard/dashboard.dart';

class LiveCameraWidget extends StatelessWidget {
  const LiveCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LiveCameraCubit(ServiceLocator.get<CameraStreamRepository>()),
      child: const _LiveCameraView(),
    );
  }
}

class _LiveCameraView extends StatelessWidget {
  const _LiveCameraView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final status = context.select(
      (LiveCameraCubit cubit) => cubit.state.status,
    );

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          // * Camera Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
            decoration: BoxDecoration(
              gradient: isDark
                  ? null
                  : LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        theme.colorScheme.primary.withAlpha(
                          (255 * 0.10).toInt(),
                        ),
                        theme.colorScheme.primary.withAlpha(
                          (255 * 0.15).toInt(),
                        ),
                      ],
                    ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(
                      (255 * 0.10).toInt(),
                    ),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text("Live Camera", style: theme.textTheme.titleSmall),
                const Spacer(),
                _LiveCameraButton(status: status),
              ],
            ),
          ),

          // * Camera Stream
          Container(
            color: const Color(0xFF111827),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: BlocBuilder<LiveCameraCubit, LiveCameraState>(
                builder: (context, state) {
                  switch (state.status) {
                    case CameraStatus.live:
                      if (state.currentFrame != null) {
                        return Image.memory(
                          state.currentFrame!,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        );
                      }

                      return _InactiveView(theme: theme);

                    case CameraStatus.connecting:
                      return const Center(child: CircularProgressIndicator());

                    case CameraStatus.error:
                      return Center(
                        child: Text(
                          "Connection Error",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      );

                    case CameraStatus.inactive:
                      return _InactiveView(theme: theme);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InactiveView extends StatelessWidget {
  const _InactiveView({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.no_photography_outlined,
          size: 40,
          color: theme.textTheme.bodyMedium?.color,
        ),
        const SizedBox(height: 8),
        Text("Camera is currently inactive", style: theme.textTheme.bodyMedium),
        const SizedBox(height: 4),
        Text(
          "Tap the Start button to activate",
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _LiveCameraButton extends StatelessWidget {
  const _LiveCameraButton({required this.status});

  final CameraStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        backgroundColor: status == CameraStatus.live
            ? isDark
                  ? const Color(0xFF450A0A)
                  : const Color(0xFFFEF2F2)
            : isDark
            ? const Color(0xFF022C22)
            : const Color(0xFFECFDF5),
        foregroundColor: isDark ? Colors.white : Colors.black,
        side: BorderSide(
          color: status == CameraStatus.live
              ? isDark
                    ? const Color(0xFF991B1B)
                    : const Color(0xFFFECACA)
              : isDark
              ? const Color(0xFF065F46)
              : const Color(0xFFA7F3D0),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: () {
        if (status == CameraStatus.live || status == CameraStatus.connecting) {
          context.read<LiveCameraCubit>().stopStreaming();
        } else {
          context.read<LiveCameraCubit>().startStreaming();
        }
      },
      icon: Icon(
        status == CameraStatus.live || status == CameraStatus.connecting
            ? Icons.stop_circle_outlined
            : Icons.remove_red_eye_outlined,
        size: 16,
        color: status == CameraStatus.live
            ? isDark
                  ? const Color(0xFFFCA5A5)
                  : const Color(0xFFB91C1C)
            : isDark
            ? const Color(0xFF6EE7B7)
            : const Color(0xFF047857),
      ),
      label: Text(
        status == CameraStatus.live
            ? "Stop"
            : status == CameraStatus.connecting
            ? "Connecting..."
            : "Start",
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: status == CameraStatus.live
              ? isDark
                    ? const Color(0xFFFCA5A5)
                    : const Color(0xFFB91C1C)
              : isDark
              ? const Color(0xFF6EE7B7)
              : const Color(0xFF047857),
        ),
      ),
    );
  }
}
