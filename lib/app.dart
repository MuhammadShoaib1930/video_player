import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/blocs/theme/theme_bloc.dart';
import 'package:video_player/core/routes/routes.dart';
import 'package:video_player/core/routes/routes_name.dart';
import 'package:video_player/core/theme/dark_theme.dart';
import 'package:video_player/core/theme/light_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeInitial>(
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,

            themeMode: state.themeMode,

            onGenerateRoute: onGenerateRoute,
            initialRoute: RoutesName.homePage,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
