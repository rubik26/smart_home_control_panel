import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_home_control_panel/data/datasources/local/theme_local_datasource.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_theme.dart';

sealed class ThemeModeEvent {}

class ToggleThemeModeEvent extends ThemeModeEvent {}

class ThemeModeState {
  final bool isDarkMode;
  ThemeModeState({required this.isDarkMode});
}

class ThemeModeBloc extends Bloc<ThemeModeEvent, bool> {
  final ToggleTheme toggleTheme;

  ThemeModeBloc(this.toggleTheme)
      : super(ThemeLocalDatasourceImpl().getThemeStatus()) {
    on<ToggleThemeModeEvent>(
      (event, emit) async {
        final newMode = await toggleTheme();
        emit(newMode);
        ThemeLocalDatasourceImpl().setThemeStatus(newMode);
      },
    );
  }
}
