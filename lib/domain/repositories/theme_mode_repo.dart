abstract class ThemeModeRepo {
  bool isDarkMode = false;
  Future<bool> toggleThemeMode();

  bool getThemeMode();
}
