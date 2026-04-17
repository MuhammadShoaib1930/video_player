import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:video_player/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(App());
}
