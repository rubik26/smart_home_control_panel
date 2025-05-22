import 'package:get_storage/get_storage.dart';

abstract class SmartLampLocalDataSource {
  int getLampStatus();
  Future<void> setLampStatus(int powerLevel);
}

class SmartLampLocalDataSourceImpl implements SmartLampLocalDataSource {
  final box = GetStorage();

  @override
  int getLampStatus() => box.read('smart_lamp') ?? 0;

  @override
  Future<void> setLampStatus(int powerLevel) async {
    await box.write('smart_lamp', powerLevel);
  }
}
