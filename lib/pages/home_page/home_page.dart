import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/blocs/theme/theme_bloc.dart';
import 'package:video_player/core/routes/routes_name.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
        actions: [
          BlocBuilder<ThemeBloc, ThemeInitial>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (state.isDark) {
                    context.read<ThemeBloc>().add(LightTheme());
                  }else{

                    context.read<ThemeBloc>().add(DarkTheme());
                  }
                },
                icon: Icon((state.isDark)?Icons.light_mode:Icons.dark_mode),
              );
            },
          ),
        ],
      ),

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
