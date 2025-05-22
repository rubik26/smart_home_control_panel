import 'package:get_storage/get_storage.dart';
import 'package:smart_home_control_panel/domain/entities/smart_window.dart';

abstract class SmartWindowLocalDatasource {
  bool getWindowOpenStatus();
  bool getWindowLockedStatus();
  Dirt getWindowDirtStatus();
  List<Dirt> getWindowDirtList();

  Future<void> setWindowOpenStatus(bool isOpen);
  Future<void> setWindowLockedStatus(bool isLocked);
  Future<void> setWindowDirtStatus(Dirt dirt);
}

class SmartWindowLocalDatasourceImpl implements SmartWindowLocalDatasource {
  final box = GetStorage();

  @override
  bool getWindowOpenStatus() => box.read('smart_window_open') ?? false;

  @override
  bool getWindowLockedStatus() => box.read('smart_window_locked') ?? false;

  @override
  Dirt getWindowDirtStatus() => box.read('smart_window_dirt') ?? Dirt.none;

  @override
  List<Dirt> getWindowDirtList() =>
      box.read('smart_window_dirt_list') ?? Dirt.values.toList();

  @override
  Future<void> setWindowOpenStatus(bool isOpen) async {
    await box.write('smart_window_open', isOpen);
  }

  @override
  Future<void> setWindowLockedStatus(bool isLocked) async {
    await box.write('smart_window_locked', isLocked);
  }

  @override
  Future<void> setWindowDirtStatus(Dirt dirt) async {
    await box.write('smart_window_dirt', dirt);
  }
}
