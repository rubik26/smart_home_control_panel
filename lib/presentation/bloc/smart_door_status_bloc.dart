import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_control_panel/data/datasources/local/smart_door_local_datasource.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_smart_door_status.dart';

sealed class SmartDoorStatusEvent {}

class ToggleSmartDoorStatusEvent extends SmartDoorStatusEvent {}

class SetSmartDoorStatusEvent extends SmartDoorStatusEvent {
  final bool isDoorOpen;
  final bool isDoorLocked;

  SetSmartDoorStatusEvent(this.isDoorOpen, this.isDoorLocked);
}

class SmartDoorStatusState {
  final bool isDoorOpen;
  final bool isDoorLocked;

  SmartDoorStatusState({
    required this.isDoorOpen,
    required this.isDoorLocked,
  });

  SmartDoorStatusState copyWith({
    bool? isDoorOpen,
    bool? isDoorLocked,
  }) {
    return SmartDoorStatusState(
      isDoorOpen: isDoorOpen ?? this.isDoorOpen,
      isDoorLocked: isDoorLocked ?? this.isDoorLocked,
    );
  }
}

class SmartDoorStatusBloc
    extends Bloc<SmartDoorStatusEvent, SmartDoorStatusState> {
  final ToggleSmartDoorStatus toggleSmartDoorStatus;

  SmartDoorStatusBloc(this.toggleSmartDoorStatus)
      : super(
          SmartDoorStatusState(
            isDoorOpen: SmartDoorLocalDataSourceImpl().getDoorOpenStatus(),
            isDoorLocked: SmartDoorLocalDataSourceImpl().getDoorLockedStatus(),
          ),
        ) {
    on<ToggleSmartDoorStatusEvent>((event, emit) async {
      final isLocked = state.isDoorLocked;
      final isOpen = state.isDoorOpen;

      if (!isOpen && isLocked) {
        print('Дверь заблокирована, открыть невозможно');
        return;
      }

      final newIsOpen = !isOpen;
      await toggleSmartDoorStatus();
      emit(state.copyWith(isDoorOpen: newIsOpen));

      print(
        'Дверь ${newIsOpen ? "открыта" : "закрыта"}',
      );

      if (isOpen && isLocked) {
        emit(state.copyWith(isDoorOpen: newIsOpen));
        print(
          'Вы заблокировали открытую дверь. Дверь будет закрыта',
        );
      }
      SmartDoorLocalDataSourceImpl().setDoorOpenStatus(isOpen);
      SmartDoorLocalDataSourceImpl().setDoorLockedStatus(isLocked);
    });

    on<SetSmartDoorStatusEvent>(
      (event, emit) {
        emit(SmartDoorStatusState(
          isDoorOpen: event.isDoorOpen,
          isDoorLocked: event.isDoorLocked,
        ));

        if (event.isDoorOpen && event.isDoorLocked) {
          print(
            'Нельзя заблокировать открытую дверь. Сначала закрываем...',
          );
          emit(SmartDoorStatusState(
            isDoorOpen: false,
            isDoorLocked: true,
          ));
        } else {
          emit(SmartDoorStatusState(
            isDoorOpen: event.isDoorOpen,
            isDoorLocked: event.isDoorLocked,
          ));
        }

        print(
          'Ручное управление: дверь ${event.isDoorOpen ? "открыта" : "закрыта"}, '
          'блокировка: ${event.isDoorLocked ? "включена" : "отключена"}',
        );
        print(
          'Ручное управление: дверь ${event.isDoorOpen ? "открыта" : "закрыта"}, '
          'блокировка: ${event.isDoorLocked ? "включена" : "отключена"}',
        );
      },
    );
  }
}
