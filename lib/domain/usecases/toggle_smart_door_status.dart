import 'package:smart_home_control_panel/domain/repositories/smart_door_repo.dart';

class ToggleSmartDoorStatus {
  final SmartDoorRepo repository;

  ToggleSmartDoorStatus({required this.repository});

  Future<void> call() async {
    final isDoorLocked = repository.getDoorLocked();
    final isDoorOpen = repository.getDoorOpen();
    await repository.toggleDoorLock(isDoorLocked);
    await repository.toggleDoorOpen(isDoorOpen);
  }
}
