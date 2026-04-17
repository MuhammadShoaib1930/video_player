import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/blocs/video_player/video_player_bloc.dart';
import 'package:video_player/services/photo_services.dart';
import 'package:video_player/services/player_services.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({required this.videoFile, required this.currentVideoIndex, super.key});

  final List<AssetEntity> videoFile;
  final int currentVideoIndex;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final PhotoServices photoServices = PhotoServices();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VideoPlayerBloc>().add(
        InitializePlayer(widget.videoFile, widget.currentVideoIndex),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<VideoPlayerBloc>();

    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onDoubleTapDown: (details) {
                          final dx = details.localPosition.dx;

                          if (dx < 150) {
                            context.read<VideoPlayerBloc>().add(SeekBackward());
                          } else {
                            context.read<VideoPlayerBloc>().add(SeekForward());
                          }
                        },
                        onLongPressStart: (_) {
                          context.read<VideoPlayerBloc>().add(ChangeSpeed(2));
                        },
                        onLongPressEnd: (_) {
                          context.read<VideoPlayerBloc>().add(ChangeSpeed(1));
                        },

                        // ONLY VIDEO WIDGET (NO REBUILD ISSUE HERE)
                        child: Video(controller: bloc.controller, controls: null),
                      ),

                      // ---------------- LOOP BUTTON ----------------
                      Positioned(
                        top: 5,
                        right: 30,
                        child: BlocSelector<VideoPlayerBloc, VideoPlayerState, int>(
                          selector: (state) => state is PlayerReady ? state.loop : 0,
                          builder: (context, loop) {
                            return IconButton(
                              onPressed: () {
                                context.read<VideoPlayerBloc>().add(ChangeLoop());
                              },
                              icon: Icon(
                                loop == 0
                                    ? Icons.not_interested_sharp
                                    : loop == 1
                                    ? Icons.repeat_one_on_outlined
                                    : Icons.repeat_on_outlined,
                              ),
                            );
                          },
                        ),
                      ),

                      // ---------------- SCREENSHOT ----------------
                      Positioned(
                        top: 5,
                        right: 60,
                        child: IconButton(
                          onPressed: () {
                            context.read<VideoPlayerBloc>().add(TakeScreenshot());

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Screenshot saved"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          icon: const Icon(Icons.image),
                        ),
                      ),

                      // ---------------- FULLSCREEN ----------------
                      Positioned(
                        right: 0,
                        bottom: 10,
                        child: IconButton(
                          onPressed: () {
                            context.read<VideoPlayerBloc>().add(
                              ToggleFullscreen(orientation == Orientation.landscape),
                            );
                          },
                          icon: Icon(
                            orientation == Orientation.landscape
                                ? Icons.fit_screen_outlined
                                : Icons.screen_rotation_rounded,
                          ),
                        ),
                      ),

                      // ---------------- PREV ----------------
                      Positioned(
                        left: 80,
                        child: IconButton(
                          onPressed: () {
                            context.read<VideoPlayerBloc>().add(PreviousPlay());
                          },
                          icon: const Icon(Icons.skip_previous),
                        ),
                      ),

                      // ---------------- Timer (OPTIMIZED) ----------------
                      Positioned(
                        top: 5,
                        right: 10,
                        child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
                          builder: (context, state) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                dropdownColor: Colors.black,
                                icon: Icon(Icons.bedtime),
                                items: [
                                  DropdownMenuItem(value: 5, child: Text("5 min")),
                                  DropdownMenuItem(value: 10, child: Text("10 min")),
                                  DropdownMenuItem(value: 15, child: Text("15 min")),
                                  DropdownMenuItem(value: 15, child: Text("20 min")),
                                  DropdownMenuItem(value: 15, child: Text("25 min")),
                                  DropdownMenuItem(value: 15, child: Text("30 min")),
                                  DropdownMenuItem(value: 15, child: Text("45 min")),
                                  DropdownMenuItem(value: 15, child: Text("60 min")),
                                  DropdownMenuItem(value: 0, child: Text("Off")),
                                ],
                                onChanged: (value) {
                                  if (value == null) return;

                                  if (value == 0) {
                                    context.read<VideoPlayerBloc>().add(CancelSleepTimer());
                                  } else {
                                    context.read<VideoPlayerBloc>().add(
                                      StartSleepTimer(Duration(minutes: value)),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      // ---------------- pitch (OPTIMIZED) ----------------
                      Positioned(
                        top: 5,
                        right: 130,
                        child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
                          builder: (context, state) {
                            double currentPitch = 1.0;

                            if (state is PlayerReady) {
                              currentPitch = state.setPitch;
                            }

                            return DropdownButtonHideUnderline(
                              child: DropdownButton<double>(
                                value: currentPitch,
                                dropdownColor: Colors.black,
                                icon: Icon(Icons.speed, color: Colors.white),

                                items: const [
                                  DropdownMenuItem(value: 0.5, child: Text("0.5x")),
                                  DropdownMenuItem(value: 1.0, child: Text("1.0x (Normal)")),
                                  DropdownMenuItem(value: 1.5, child: Text("1.5x")),
                                  DropdownMenuItem(value: 2.0, child: Text("2.0x")),
                                ],

                                onChanged: (value) {
                                  if (value == null) return;

                                  context.read<VideoPlayerBloc>().add(SetPitch(value));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      // ---------------- PLAY/PAUSE (OPTIMIZED) ----------------
                      Positioned(
                        child: BlocSelector<VideoPlayerBloc, VideoPlayerState, bool>(
                          selector: (state) => state is PlayerReady ? state.isplaying : false,
                          builder: (context, isPlaying) {
                            return IconButton(
                              onPressed: () {
                                context.read<VideoPlayerBloc>().add(PlayPause());
                              },
                              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                            );
                          },
                        ),
                      ),

                      // ---------------- NEXT ----------------
                      Positioned(
                        right: 80,
                        child: IconButton(
                          onPressed: () {
                            context.read<VideoPlayerBloc>().add(NextPlay());
                          },
                          icon: const Icon(Icons.skip_next),
                        ),
                      ),

                      // ---------------- TIME TEXT ----------------
                      Positioned(
                        bottom: 40,
                        left: 20,
                        child: BlocSelector<VideoPlayerBloc, VideoPlayerState, String>(
                          selector: (state) {
                            if (state is PlayerReady) {
                              return "${PlayerServices().formatTime(state.position)} | ${PlayerServices().formatTime(state.duration)}";
                            }
                            return "00:00 | 00:00";
                          },
                          builder: (context, text) {
                            return Text(text, style: Theme.of(context).textTheme.bodySmall);
                          },
                        ),
                      ),

                      // ---------------- SLIDER ----------------
                      Positioned(
                        bottom: 5,
                        left: 0,
                        right: 30,
                        child: BlocSelector<VideoPlayerBloc, VideoPlayerState, PlayerReady?>(
                          selector: (state) => state is PlayerReady ? state : null,
                          builder: (context, state) {
                            if (state == null) return const SizedBox();

                            return Slider(
                              min: 0,
                              max: state.duration.inSeconds.toDouble(),
                              value: state.position.inSeconds
                                  .clamp(0, state.duration.inSeconds)
                                  .toDouble(),
                              secondaryTrackValue: state.buffring.inSeconds.toDouble(),
                              onChanged: (value) {
                                context.read<VideoPlayerBloc>().player.seek(
                                  Duration(seconds: value.toInt()),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // ---------------- VIDEO LIST ----------------
                if (orientation != Orientation.landscape)
                  Expanded(
                    child: BlocSelector<VideoPlayerBloc, VideoPlayerState, int>(
                      selector: (state) => state is PlayerReady ? state.currentIndex : 0,
                      builder: (context, currentIndex) {
                        return ListView.builder(
                          itemCount: widget.videoFile.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context.read<VideoPlayerBloc>().add(ChangeIndex(index));
                              },
                              child: Container(
                                color: currentIndex == index ? Colors.blue : Colors.transparent,
                                child: Row(
                                  children: [
                                    FutureBuilder(
                                      future: photoServices.thumbnail(widget.videoFile[index]),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData && snapshot.data != null) {
                                          return Image.memory(snapshot.data!, width: 150);
                                        }
                                        return Container(
                                          width: 150,
                                          height: 100,
                                          color: Colors.grey,
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        widget.videoFile[index].title ?? "",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
