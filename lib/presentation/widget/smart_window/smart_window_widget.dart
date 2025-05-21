import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_control_panel/domain/entities/smart_window.dart';
import 'package:smart_home_control_panel/presentation/bloc/smart_window_status_bloc.dart';

class SmartWindowWidget extends StatefulWidget {
  const SmartWindowWidget({super.key});

  @override
  State<SmartWindowWidget> createState() => _SmartWindowWidgetState();
}

class _SmartWindowWidgetState extends State<SmartWindowWidget> {
  @override
  Widget build(BuildContext context) {
    final isIOS = Platform.isIOS;

    return BlocBuilder<SmartWindowStatusBloc, SetSmartWindowStatusEvent>(
      builder: (context, state) {
        IconData icon;
        Color color;

        if (state.isOpen) {
          icon = Icons.window;
          color = Colors.green;
        } else if (state.isLocked) {
          icon = Icons.lock;
          color = Colors.red;
        } else {
          icon = Icons.window;
          color = Colors.orange;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
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
                  child: Icon(
                    icon,
                    size: 100,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Window Status: ${state.isOpen ? "Open" : "Closed"} | ${state.isLocked ? "Locked" : "Unlocked"}',
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontFamily: isIOS ? 'San Francisco' : null,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (state.dirt != Dirt.none)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Icon(Icons.warning_amber_rounded, color: Colors.brown),
                    Text(
                      'Dirty: ${state.dirt.name}',
                      style: const TextStyle(color: Colors.brown, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    isIOS
                        ? CupertinoButton.filled(
                            onPressed: () {
                              context.read<SmartWindowStatusBloc>().add(
                                    SetSmartWindowStatusEvent(
                                      isOpen: state.isOpen,
                                      isLocked: state.isLocked,
                                      dirtList: const [
                                        Dirt.none,
                                        Dirt.rainStains,
                                        Dirt.dust
                                      ],
                                      dirt: Dirt.none,
                                    ),
                                  );
                            },
                            child: const Text("Clean Window"),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              context.read<SmartWindowStatusBloc>().add(
                                    SetSmartWindowStatusEvent(
                                      isOpen: state.isOpen,
                                      isLocked: state.isLocked,
                                      dirtList: const [
                                        Dirt.none,
                                        Dirt.rainStains,
                                        Dirt.dust
                                      ],
                                      dirt: Dirt.none,
                                    ),
                                  );
                            },
                            child: const Text("Clean Window"),
                          ),
                  ],
                ),
              const SizedBox(height: 20),
              isIOS
                  ? CupertinoButton(
                      onPressed: () {
                        context.read<SmartWindowStatusBloc>().add(
                              ToggleSmartWindowStatusEvent(),
                            );
                      },
                      child: const Text("Open / Close"),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        context.read<SmartWindowStatusBloc>().add(
                              ToggleSmartWindowStatusEvent(),
                            );
                      },
                      child: const Text("Open / Close"),
                    ),
              const SizedBox(height: 10),
              isIOS
                  ? CupertinoButton(
                      onPressed: () {
                        context.read<SmartWindowStatusBloc>().add(
                              SetSmartWindowStatusEvent(
                                isOpen: state.isOpen,
                                isLocked: !state.isLocked,
                                dirtList: state.dirtList,
                                dirt: state.dirt,
                              ),
                            );
                      },
                      child: const Text("Lock / Unlock"),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        context.read<SmartWindowStatusBloc>().add(
                              SetSmartWindowStatusEvent(
                                isOpen: state.isOpen,
                                isLocked: !state.isLocked,
                                dirtList: state.dirtList,
                                dirt: state.dirt,
                              ),
                            );
                      },
                      child: const Text("Lock / Unlock"),
                    ),
            ],
          ),
        );
      },
    );
  }
}
