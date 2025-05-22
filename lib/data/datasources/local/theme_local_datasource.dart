import 'package:get_storage/get_storage.dart';

abstract class ThemeLocalDatasource {
  bool getThemeStatus();
  Future<void> setThemeStatus(bool isDarkMode);
}

class ThemeLocalDatasourceImpl implements ThemeLocalDatasource {
  final box = GetStorage();

  @override
  bool getThemeStatus() => box.read('theme') ?? false;

  @override
  Future<void> setThemeStatus(bool isDarkMode) async {
    await box.write('theme', isDarkMode);
  }
}
