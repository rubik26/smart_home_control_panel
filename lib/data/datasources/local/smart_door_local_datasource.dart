import 'package:get_storage/get_storage.dart';

abstract class SmartDoorLocalDataSource {
  bool getDoorOpenStatus();
  bool getDoorLockedStatus();
  Future<void> setDoorOpenStatus(bool isOpen);
  Future<void> setDoorLockedStatus(bool isLocked);
}

class SmartDoorLocalDataSourceImpl implements SmartDoorLocalDataSource {
  final box = GetStorage();

  @override
  bool getDoorOpenStatus() => box.read('smart_door_open') ?? false;

  @override
  bool getDoorLockedStatus() => box.read('smart_door_locked') ?? false;

  @override
  Future<void> setDoorOpenStatus(bool isOpen) async {
    await box.write('smart_door_open', isOpen);
  }

  @override
  Future<void> setDoorLockedStatus(bool isLocked) async {
    await box.write('smart_door_locked', isLocked);
  }
}
