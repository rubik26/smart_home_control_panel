import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_theme.dart';

sealed class ThemeModeEvent {}

class ToggleThemeModeEvent extends ThemeModeEvent {}

class ThemeModeState {
  final bool isDarkMode;
  ThemeModeState({required this.isDarkMode});
}

class ThemeModeBloc extends Bloc<ThemeModeEvent, bool> {
  final GetStorage box = GetStorage();
  final ToggleTheme toggleTheme;

  ThemeModeBloc(this.toggleTheme)
      : super(GetStorage().read('is_dark_mode') ?? false) {
    on<ToggleThemeModeEvent>(
      (event, emit) async {
        final newMode = await toggleTheme();
        emit(newMode);
        box.write('is_dark_mode', newMode);
      },
    );
  }
}
