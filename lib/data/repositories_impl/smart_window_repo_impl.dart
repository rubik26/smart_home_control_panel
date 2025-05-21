import 'dart:math';

import 'package:smart_home_control_panel/domain/entities/smart_window.dart';
import 'package:smart_home_control_panel/domain/repositories/smart_window_repo.dart';

class SmartWindowRepoImpl extends SmartWindowRepo {
  Random random = Random();

  bool _isWindowOpen = false;
  bool _isWindowLocked = false;
  List<Dirt> _dirtList = [Dirt.none];

  @override
  List<Dirt> getWindowDirt() => _dirtList;

  @override
  bool getWindowLocked() => _isWindowLocked;

  @override
  bool getWindowOpen() => _isWindowOpen;

  @override
  Future<bool> toggleWindowDirt(Dirt dirt) {
    return Future.delayed(const Duration(seconds: 3), () {
      _dirtList = dirtList;
      dirt = _dirtList[random.nextInt(_dirtList.length)];
      return _dirtList.contains(dirt);
    });
  }

  @override
  Future<bool> toggleWindowLock(bool isWindowLocked) {
    return Future.delayed(const Duration(seconds: 1), () {
      _isWindowLocked = isWindowLocked;
      return _isWindowLocked;
    });
  }

  @override
  Future<bool> toggleWindowOpen(bool isWindowOpen) {
    return Future.delayed(const Duration(seconds: 2), () {
      _isWindowOpen = isWindowOpen;
      return _isWindowOpen;
    });
  }
}
