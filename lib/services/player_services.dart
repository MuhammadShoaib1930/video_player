import 'dart:io';

import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:photo_manager/photo_manager.dart';

class PlayerServices {
  String formatTime(Duration d) {
    final hours = d.inHours.remainder(60).toString().padLeft(2, '0');
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (hours == "00") {
      return "$minutes:$seconds";
    } else {
      return "$hours:$minutes:$seconds";
    }
  }


  Future<List<Media>> assetEntityToMedia(List<AssetEntity> data) async {
    List<Media> media = [];
    for (var item in data) {
      final file = await item.file;
      if (file != null) {
        final f = file.path;
        media.add(Media(f));
      }
    }

    return media;
  }

  double aspectRatio(Player player) {
    final int w = player.state.width ?? 16;
    final int h = player.state.height ?? 8;
    double ratio;
    if (w > 0 && h > 0) {
      ratio = w / h;
    } else {
      ratio = 16 / 9;
    }
    return ratio;
  }

  Future<void> screenshotSave(Uint8List? bytes) async {
    if (bytes == null) return;

    final dir = Directory('/storage/emulated/0/Download/videoImages');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final file = File('${dir.path}/shot_${DateTime.now().millisecondsSinceEpoch}.png');

    await file.writeAsBytes(bytes);
  }

  Future<void> enterFullScreen() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> exitFullScreen() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}
