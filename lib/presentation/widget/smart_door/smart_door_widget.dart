import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_control_panel/l10n/app_localizations.dart';
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
        final isIOS = Platform.isIOS;

        final icon =
            state.isDoorOpen ? Icons.door_front_door : Icons.door_sliding;

        final color = state.isDoorOpen
            ? Colors.green
            : (state.isDoorLocked ? Colors.red : Colors.orange);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      color.withOpacity(0.3),
                      color.withOpacity(0.1),
                    ],
                    center: Alignment.center,
                    radius: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
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
                      size: 90,
                      color: color,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                (state.isDoorOpen
                    ? AppLocalizations.of(context).doorOpen()
                    : AppLocalizations.of(context).doorClosed()),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                state.isDoorLocked
                    ? AppLocalizations.of(context).doorLockEnabled()
                    : AppLocalizations.of(context).doorLockDisabled(),
                style: TextStyle(
                  fontSize: 16,
                  color: color.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  isIOS
                      ? CupertinoButton.filled(
                          onPressed: () {
                            context
                                .read<SmartDoorStatusBloc>()
                                .add(ToggleSmartDoorStatusEvent());
                          },
                          child: Text(AppLocalizations.of(context).openClose),
                        )
                      : ElevatedButton.icon(
                          icon: Icon(state.isDoorOpen
                              ? Icons.close
                              : Icons.door_front_door),
                          onPressed: () {
                            context
                                .read<SmartDoorStatusBloc>()
                                .add(ToggleSmartDoorStatusEvent());
                          },
                          label: Text(AppLocalizations.of(context).openClose),
                        ),
                  isIOS
                      ? CupertinoButton(
                          onPressed: () {
                            context.read<SmartDoorStatusBloc>().add(
                                  SetSmartDoorStatusEvent(
                                    state.isDoorOpen,
                                    !state.isDoorLocked,
                                  ),
                                );
                          },
                          child: Text(AppLocalizations.of(context).lockUnlock),
                        )
                      : ElevatedButton.icon(
                          icon: Icon(state.isDoorLocked
                              ? Icons.lock_open
                              : Icons.lock_outline),
                          onPressed: () {
                            context.read<SmartDoorStatusBloc>().add(
                                  SetSmartDoorStatusEvent(
                                    state.isDoorOpen,
                                    !state.isDoorLocked,
                                  ),
                                );
                          },
                          label: Text(AppLocalizations.of(context).lockUnlock),
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
