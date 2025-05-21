import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_home_control_panel/domain/entities/smart_window.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_smart_window_status.dart';

sealed class SmartWindowStatusEvent {}

class ToggleSmartWindowStatusEvent extends SmartWindowStatusEvent {}

class SetSmartWindowStatusEvent extends SmartWindowStatusEvent {
  final bool isOpen;
  final bool isLocked;
  final List<Dirt> dirtList;
  final Dirt dirt;
  SetSmartWindowStatusEvent({
    required this.isOpen,
    required this.isLocked,
    required this.dirtList,
    required this.dirt,
  });

  SetSmartWindowStatusEvent copyWith({
    bool? isOpen,
    bool? isLocked,
    List<Dirt>? dirtList,
    Dirt? dirt,
  }) {
    return SetSmartWindowStatusEvent(
      isOpen: isOpen ?? this.isOpen,
      isLocked: isLocked ?? this.isLocked,
      dirtList: dirtList ?? this.dirtList,
      dirt: dirt ?? this.dirt,
    );
  }
}

class SmartWindowStatusBloc
    extends Bloc<SmartWindowStatusEvent, SetSmartWindowStatusEvent> {
  final ToggleSmartWindowStatus toggleSmartWindowStatus;

  final Random random = Random();

  final box = GetStorage();

  SmartWindowStatusBloc(this.toggleSmartWindowStatus)
      : super(
          SetSmartWindowStatusEvent(
            isOpen: GetStorage().read('smart_window_open') ?? false,
            isLocked: GetStorage().read('smart_window_locked') ?? false,
            dirtList: [
              Dirt.rainStains,
              Dirt.dust,
              Dirt.birdDroppings,
              Dirt.pollen,
              Dirt.fingerprints
            ],
            dirt: GetStorage().read('smart_window_dirt') ?? Dirt.none,
          ),
        ) {
    on<ToggleSmartWindowStatusEvent>(
      (event, emit) async {
        final dirtList = state.dirtList;
        final dirt = (dirtList.isNotEmpty)
            ? dirtList[Random().nextInt(dirtList.length)]
            : Dirt.none;

        final isOpen = state.isOpen;
        final isLocked = state.isLocked;

        if (!isOpen && isLocked) {
          print('Окно заблокировано, открыть невозможно');
          return;
        }

        final newIsOpen = !isOpen;

        await toggleSmartWindowStatus();
        emit(
          state.copyWith(isOpen: newIsOpen, dirt: dirt),
        );

        box.write('smart_window_open', newIsOpen);
        box.write('smart_window_locked', isLocked);
        box.write('smart_window_dirt', dirt);
      },
    );

    on<SetSmartWindowStatusEvent>(
      (event, emit) async {
        bool newIsOpen = event.isOpen;
        bool newIsLocked = event.isLocked;

        if (event.isOpen && event.isLocked) {
          newIsOpen = false;
        }

        Dirt dirt = event.dirt;
        if (dirt == Dirt.none && event.dirtList.isNotEmpty) {
          final dirtList = event.dirtList;
          dirt = dirtList[random.nextInt(dirtList.length)];
        }

        emit(
          state.copyWith(
            isOpen: newIsOpen,
            isLocked: newIsLocked,
            dirtList: event.dirtList,
            dirt: dirt,
          ),
        );
      },
    );
  }
}
