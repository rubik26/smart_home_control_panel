import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_lamp_power.dart';

sealed class SmartModeEvent {}

class ToggleSmartLampModeEvent extends SmartModeEvent {}

class SetPowerLevelEvent extends SmartModeEvent {
  final int powerLevel;
  SetPowerLevelEvent(this.powerLevel);
}

class SmartLampModeBloc extends Bloc<SmartModeEvent, int> {
  final GetStorage box;
  final ToggleLampPower toggleLampPower;

  SmartLampModeBloc(this.toggleLampPower)
      : box = GetStorage(),
        super(GetStorage().read('smart_lamp_power') ?? 0) {
    on<ToggleSmartLampModeEvent>((event, emit) async {
      final newPower = await toggleLampPower();
      emit(newPower);
      box.write('smart_lamp_power', newPower);
      print('Smart mode power level: $newPower');
    });

    on<SetPowerLevelEvent>((event, emit) {
      emit(event.powerLevel);
      box.write('smart_lamp_power', event.powerLevel);
      print('Smart mode power level set to: ${event.powerLevel}');
    });
  }
}
