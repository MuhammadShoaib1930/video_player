part of 'video_player_bloc.dart';

sealed class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object?> get props => [];
}

final class InitializePlayer extends VideoPlayerEvent {
  final List<AssetEntity> assets;
  final int startIndex;

  const InitializePlayer(this.assets, this.startIndex);

  @override
  List<Object?> get props => [assets, startIndex];
}


final class PlayPause extends VideoPlayerEvent {}

final class SeekForward extends VideoPlayerEvent {}

final class SeekBackward extends VideoPlayerEvent {}

final class ChangeIndex extends VideoPlayerEvent {
  final int index;

  const ChangeIndex(this.index);

  @override
  List<Object?> get props => [index];
}

class StartSleepTimer extends VideoPlayerEvent {
  final Duration duration;
  const StartSleepTimer(this.duration);
}

final class SetPitch extends VideoPlayerEvent {
  final double pitch;
  const SetPitch(this.pitch);

  @override
  List<Object> get props => [pitch];
}

class CancelSleepTimer extends VideoPlayerEvent {}

final class NextPlay extends VideoPlayerEvent {}

final class PreviousPlay extends VideoPlayerEvent {}

final class ChangeSpeed extends VideoPlayerEvent {
  final double speed;

  const ChangeSpeed(this.speed);

  @override
  List<Object?> get props => [speed];
}

final class ChangePitch extends VideoPlayerEvent {
  final double pitch;

  const ChangePitch(this.pitch);

  @override
  List<Object?> get props => [pitch];
}

final class ChangeLoop extends VideoPlayerEvent {}

final class ChangeVolume extends VideoPlayerEvent {
  final double volume;

  const ChangeVolume(this.volume);

  @override
  List<Object?> get props => [volume];
}

final class TakeScreenshot extends VideoPlayerEvent {}

final class ToggleFullscreen extends VideoPlayerEvent {
  final bool isFullscreen;

  const ToggleFullscreen(this.isFullscreen);

  @override
  List<Object?> get props => [isFullscreen];
}
