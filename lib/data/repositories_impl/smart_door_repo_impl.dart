import 'package:smart_home_control_panel/domain/repositories/smart_door_repo.dart';

class SmartDoorRepoImpl extends SmartDoorRepo {
  bool _isDoorOpen = false;
  bool _isDoorLocked = false;
  @override
  bool getDoorLocked() {
    return _isDoorLocked;
  }

  @override
  bool getDoorOpen() {
    return _isDoorOpen;
  }

  @override
  Future<bool> toggleDoorLock(bool isDoorLocked) {
    return Future.delayed(const Duration(seconds: 1), () {
      _isDoorLocked = isDoorLocked;
      return _isDoorLocked;
    });
  }

  @override
  Future<bool> toggleDoorOpen(bool isDoorOpen) {
    return Future.delayed(const Duration(seconds: 1), () {
      _isDoorOpen = isDoorOpen;
      return _isDoorOpen;
    });
  }
}
