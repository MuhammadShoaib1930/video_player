part of 'video_player_bloc.dart';

sealed class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object> get props => [];
}

final class PlayerInitial extends VideoPlayerState {}

final class PlayerReady extends VideoPlayerState {
  final bool isplaying;
  final Duration position;
  final Duration duration;
  final Duration buffring;
  final double aspectRatio;
  final int loop;
  final int currentIndex;
  final double ratSpeed;
  final double setPitch;
  const PlayerReady({
    required this.duration,
    required this.isplaying,
    required this.position,
    required this.buffring,
    required this.aspectRatio,
    required this.loop,
    required this.currentIndex,
    required this.ratSpeed,
    required this.setPitch,
  });
  @override
  List<Object> get props => [
    position,
    isplaying,
    duration,
    loop,
    aspectRatio,
    buffring,
    currentIndex,
    ratSpeed,
    setPitch,
  ];
  PlayerReady copyWith({
    bool? isplaying,
    Duration? position,
    Duration? duration,
    Duration? buffring,
    double? aspectRatio,
    double? ratSpeed,
    double? setPitch,
    int? loop,
    int? currentIndex,
  }) {
    return PlayerReady(
      duration: duration ?? this.duration,
      isplaying: isplaying ?? this.isplaying,
      position: position ?? this.position,
      buffring: buffring ?? this.buffring,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      loop: loop ?? this.loop,
      currentIndex: currentIndex ?? this.currentIndex,
      ratSpeed: ratSpeed ?? this.ratSpeed,
      setPitch: setPitch ?? this.setPitch,
    );
  }
}

final class PlayerLoading extends VideoPlayerState {}
