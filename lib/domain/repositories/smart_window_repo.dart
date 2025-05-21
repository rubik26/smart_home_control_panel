import 'package:smart_home_control_panel/domain/entities/smart_window.dart';

abstract class SmartWindowRepo {
  bool isOpen = false;
  bool isLocked = false;

  List<Dirt> dirtList = [Dirt.none];

  Future<bool> toggleWindowOpen(bool isWindowOpen);
  Future<bool> toggleWindowLock(bool isWindowLocked);
  Future<bool> toggleWindowDirt(Dirt dirt);

  bool getWindowOpen();
  bool getWindowLocked();
  List<Dirt> getWindowDirt();
}
