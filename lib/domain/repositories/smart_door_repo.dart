abstract class SmartDoorRepo {
  bool isDoorOpen = false;
  bool isDoorLocked = false;

  Future<bool> toggleDoorOpen(bool isDoorOpen);
  Future<bool> toggleDoorLock(bool isDoorLocked);
  bool getDoorOpen();
  bool getDoorLocked();
}
