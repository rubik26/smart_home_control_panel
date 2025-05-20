import 'package:smart_home_control_panel/domain/repositories/smart_lamp_repo.dart';

class ToggleLampPower {
  final SmartLampRepo smartLampRepo;
  ToggleLampPower({required this.smartLampRepo});

  Future<int> call() async {
    final currentPower = smartLampRepo.getPower();
    final newPower = (currentPower + 1) % 7;
    return await smartLampRepo.togglePower(newPower);
  }
}
