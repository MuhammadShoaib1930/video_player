// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/services/player_services.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final Player player = Player(configuration: PlayerConfiguration(pitch: true));
  late final VideoController controller;
  Timer? sleepTimer;
  Duration? sleepDuration;
  bool isSleepEnabled = false;
  Timer? controlsTimer;
  final PlayerServices playerServices = PlayerServices();

  StreamSubscription? _posSub;
  StreamSubscription? _bufSub;
  StreamSubscription? _durSub;

  int totalCount = 0;

  VideoPlayerBloc() : super(PlayerInitial()) {
    controller = VideoController(player);

    on<InitializePlayer>(_init);
    on<PlayPause>(_playPause);
    on<SeekForward>(_seekForward);
    on<SeekBackward>(_seekBackward);
    on<ChangeIndex>(_changeIndex);
    on<NextPlay>(_next);
    on<PreviousPlay>(_previous);
    on<ChangeSpeed>(_speed);
    on<ChangePitch>(_pitch);
    on<ChangeVolume>(_volume);
    on<ChangeLoop>(_loop);
    on<ToggleFullscreen>(_fullscreen);
    on<TakeScreenshot>(_screenshot);
    on<StartSleepTimer>(_startSleepTimer);
    on<CancelSleepTimer>(_cancelSleepTimer);
    on<SetPitch>(_setPitch);
  }

  // ---------------- INIT ----------------

  Future<void> _init(InitializePlayer event, Emitter<VideoPlayerState> emit) async {
    emit(PlayerLoading());

    final files = await playerServices.assetEntityToMedia(event.assets);

    await player.open(Playlist(files));

    totalCount = files.length;

    emit(
      PlayerReady(
        duration: Duration.zero,
        position: Duration.zero,
        buffring: Duration.zero,
        isplaying: true,
        currentIndex: event.startIndex,
        aspectRatio: playerServices.aspectRatio(player),
        loop: 0,
        ratSpeed: 1,
        setPitch: 1,
      ),
    );

    _startStreams();
  }

  // ---------------- STREAMS (NO EVENTS) ----------------

  void _startStreams() {
    _posSub?.cancel();
    _bufSub?.cancel();
    _durSub?.cancel();

    _posSub = player.stream.position.listen((pos) {
      final s = state;
      if (s is PlayerReady) {
        emit(s.copyWith(position: pos));
      }
    });

    _bufSub = player.stream.buffer.listen((buf) {
      final s = state;
      if (s is PlayerReady) {
        emit(s.copyWith(buffring: buf));
      }
    });

    _durSub = player.stream.duration.listen((dur) {
      final s = state;
      if (s is PlayerReady) {
        emit(s.copyWith(duration: dur));
      }
    });
  }

  // ---------------- PLAY CONTROL ----------------

  Future<void> _playPause(PlayPause event, Emitter<VideoPlayerState> emit) async {
    final s = state;
    if (s is! PlayerReady) return;

    if (player.state.playing) {
      await player.pause();
      emit(s.copyWith(isplaying: false));
    } else {
      await player.play();
      emit(s.copyWith(isplaying: true));
    }
  }

  Future<void> _seekForward(SeekForward event, Emitter<VideoPlayerState> emit) async {
    await player.seek(player.state.position + const Duration(seconds: 10));
  }

  Future<void> _seekBackward(SeekBackward event, Emitter<VideoPlayerState> emit) async {
    await player.seek(player.state.position - const Duration(seconds: 10));
  }

  // ---------------- INDEX CONTROL ----------------

  Future<void> _changeIndex(ChangeIndex event, Emitter<VideoPlayerState> emit) async {
    await _playAt(event.index);
  }

  Future<void> _next(NextPlay event, Emitter<VideoPlayerState> emit) async {
    final s = state;
    if (s is PlayerReady && s.currentIndex < totalCount - 1) {
      await _playAt(s.currentIndex + 1);
    }
  }

  Future<void> _previous(PreviousPlay event, Emitter<VideoPlayerState> emit) async {
    final s = state;
    if (s is PlayerReady && s.currentIndex > 0) {
      await _playAt(s.currentIndex - 1);
    }
  }

  Future<void> _playAt(int index) async {
    final s = state;
    if (s is! PlayerReady) return;

    await player.pause();
    await player.jump(index);
    await player.play();

    emit(s.copyWith(currentIndex: index, isplaying: true));
  }

  // ---------------- SETTINGS ----------------

  Future<void> _speed(ChangeSpeed event, Emitter<VideoPlayerState> emit) async {
    await player.setRate(event.speed);

    final s = state;
    if (s is PlayerReady) {
      emit(s.copyWith(ratSpeed: event.speed));
    }
  }

  Future<void> _pitch(ChangePitch event, Emitter<VideoPlayerState> emit) async {
    await player.setPitch(event.pitch);

    final s = state;
    if (s is PlayerReady) {
      emit(s.copyWith(setPitch: event.pitch));
    }
  }

  Future<void> _volume(ChangeVolume event, Emitter<VideoPlayerState> emit) async {
    await player.setVolume(event.volume);
  }

  Future<void> _loop(ChangeLoop event, Emitter<VideoPlayerState> emit) async {
    final s = state;
    if (s is! PlayerReady) return;

    final next = (s.loop + 1) % 3;

    if (next == 1) {
      await player.setPlaylistMode(PlaylistMode.single);
    } else if (next == 2) {
      await player.setPlaylistMode(PlaylistMode.loop);
    } else {
      await player.setPlaylistMode(PlaylistMode.none);
    }

    emit(s.copyWith(loop: next));
  }

  // ---------------- EXTRA ----------------

  Future<void> _fullscreen(ToggleFullscreen event, Emitter<VideoPlayerState> emit) async {
    if (event.isFullscreen) {
      playerServices.exitFullScreen();
    } else {
      playerServices.enterFullScreen();
    }
  }

  Future<void> _screenshot(TakeScreenshot event, Emitter<VideoPlayerState> emit) async {
    final bytes = await player.screenshot();
    await playerServices.screenshotSave(bytes);
  }

  // ---------------- CLEANUP ----------------

  @override
  Future<void> close() {
    _posSub?.cancel();
    _bufSub?.cancel();
    _durSub?.cancel();
    player.dispose();
    return super.close();
  }

  FutureOr<void> _startSleepTimer(StartSleepTimer event, Emitter<VideoPlayerState> emit) {
    sleepTimer?.cancel();

    isSleepEnabled = true;
    sleepDuration = event.duration;

    sleepTimer = Timer(event.duration, () {
      player.pause(); // or player.dispose()
    });
  }

  FutureOr<void> _cancelSleepTimer(CancelSleepTimer event, Emitter<VideoPlayerState> emit) {
    sleepTimer?.cancel();
    isSleepEnabled = false;
  }

  FutureOr<void> _setPitch(SetPitch event, Emitter<VideoPlayerState> emit) async {
    await player.setPitch(event.pitch);

    if (state is PlayerReady) {
      emit((state as PlayerReady).copyWith(setPitch: event.pitch));
    }
  }


}
