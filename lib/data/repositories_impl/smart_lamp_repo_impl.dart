import 'package:smart_home_control_panel/domain/repositories/smart_lamp_repo.dart';

class SmartLampRepoImpl extends SmartLampRepo {
  int _power = 0;
  @override
  int getPower() {
    return _power;
  }

  @override
  Future<int> togglePower(int level) {
    return Future.delayed(const Duration(seconds: 1), () {
      _power = level.clamp(0, 6);
      return _power;
    });
  }
}
