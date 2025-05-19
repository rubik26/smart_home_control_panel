import 'package:smart_home_control_panel/domain/repositories/theme_mode_repo.dart';

class ThemeModeRepoImpl extends ThemeModeRepo {
  bool _isDarkMode = false;

  @override
  Future<bool> toggleThemeMode() async {
    _isDarkMode = !_isDarkMode;
    return _isDarkMode;
  }

  @override
  bool getThemeMode() => _isDarkMode;
}
