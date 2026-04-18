import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeInitial> {
  ThemeBloc() : super(ThemeInitial(ThemeMode.light,false)) {
    on<LightTheme>(_lightTheme);
    on<DarkTheme>(_darkTheme);
  }

  FutureOr<void> _lightTheme(LightTheme event, Emitter<ThemeInitial> emit) {
    emit(ThemeInitial(ThemeMode.light,false));
  }

  FutureOr<void> _darkTheme(DarkTheme event, Emitter<ThemeInitial> emit) {
    emit(ThemeInitial(ThemeMode.dark,true));
  }
}
