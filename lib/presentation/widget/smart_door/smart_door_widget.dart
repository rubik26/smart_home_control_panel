import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_control_panel/presentation/bloc/smart_door_status_bloc.dart';

class SmartDoorWidget extends StatefulWidget {
  const SmartDoorWidget({super.key});

  @override
  State<SmartDoorWidget> createState() => _SmartDoorWidgetState();
}

class _SmartDoorWidgetState extends State<SmartDoorWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartDoorStatusBloc, SmartDoorStatusState>(
      builder: (context, state) {
        final icon =
            state.isDoorOpen ? Icons.door_front_door : Icons.door_sliding;

        final color = state.isDoorOpen
            ? Colors.green
            : (state.isDoorLocked ? Colors.red : Colors.orange);

        final statusText = 'Door: ${state.isDoorOpen ? 'Open' : 'Closed'}\n'
            'Lock: ${state.isDoorLocked ? 'Enabled' : 'Disabled'}';

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.2),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: Icon(
                    icon,
                    key: ValueKey(icon),
                    size: 100,
                    color: color,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(statusText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Platform.isIOS
                ? CupertinoButton.filled(
                    onPressed: () {
                      context
                          .read<SmartDoorStatusBloc>()
                          .add(ToggleSmartDoorStatusEvent());
                    },
                    child: const Text('Open / Close'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      context
                          .read<SmartDoorStatusBloc>()
                          .add(ToggleSmartDoorStatusEvent());
                    },
                    child: const Text('Open / Close'),
                  ),
            const SizedBox(height: 10),
            Platform.isIOS
                ? CupertinoButton(
                    onPressed: () {
                      context.read<SmartDoorStatusBloc>().add(
                            SetSmartDoorStatusEvent(
                              state.isDoorOpen,
                              !state.isDoorLocked,
                            ),
                          );
                    },
                    child: const Text('Lock / Unlock'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      context.read<SmartDoorStatusBloc>().add(
                            SetSmartDoorStatusEvent(
                              state.isDoorOpen,
                              !state.isDoorLocked,
                            ),
                          );
                    },
                    child: const Text('Lock / Unlock'),
                  ),
          ],
        );
      },
    );
  }
}
