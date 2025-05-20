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
        IconData icon;
        Color color;

        if (state.isDoorOpen) {
          icon = Icons.door_front_door;
          color = Colors.green;
        } else if (state.isDoorLocked) {
          icon = Icons.door_sliding;
          color = Colors.red;
        } else {
          icon = Icons.door_sliding;
          color = Colors.orange;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
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
            Text(
              'Door: ${state.isDoorOpen ? 'Open' : 'Closed'}\n'
              'Lock: ${state.isDoorLocked ? 'Enabled' : 'Disabled'}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<SmartDoorStatusBloc>().add(
                      ToggleSmartDoorStatusEvent(),
                    );
              },
              child: const Text('Open / Close'),
            ),
            ElevatedButton(
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
