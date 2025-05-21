import 'package:smart_home_control_panel/domain/entities/smart_window.dart';
import 'package:smart_home_control_panel/domain/repositories/smart_window_repo.dart';

class ToggleSmartWindowStatus {
  final SmartWindowRepo repository;

  ToggleSmartWindowStatus({required this.repository});

  Future<void> call() async {
    final isWindowOpen = repository.getWindowOpen();
    final isWindowLocked = repository.getWindowLocked();
    final dirtList = repository.getWindowDirt();
    final dirt = dirtList.isNotEmpty ? dirtList[0] : Dirt.none;
    await repository.toggleWindowDirt(dirt);
    await repository.toggleWindowLock(isWindowLocked);
    await repository.toggleWindowOpen(isWindowOpen);
  }
}
