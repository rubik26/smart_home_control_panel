import 'package:smart_home_control_panel/domain/repositories/theme_mode_repo.dart';

class ToggleTheme {
  final ThemeModeRepo themeModeRepo;
  ToggleTheme({required this.themeModeRepo});

  Future<bool> call() async {
    return await themeModeRepo.toggleThemeMode();
  }
}
