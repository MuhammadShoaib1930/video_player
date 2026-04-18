part of 'theme_bloc.dart';

final class ThemeInitial extends Equatable {
  final bool isDark;
  final ThemeMode themeMode;
  const ThemeInitial(this.themeMode,this.isDark);
  @override
  List<Object> get props => [themeMode,isDark];
}
