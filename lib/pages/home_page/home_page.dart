import 'package:flutter/material.dart';
import 'package:video_player/core/routes/routes_name.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.videos);
              },
              child: Text("Videos"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.mediaViewImages);
              },
              child: Text("Images"),
            ),
          ],
        ),
      ),
    );
  }
}
