import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_control_panel/domain/entities/smart_window.dart';
import 'package:smart_home_control_panel/l10n/app_localizations.dart';
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
          icon = Icons.open_in_browser;
          color = Colors.green;
        } else if (state.isLocked) {
          icon = Icons.lock_outline;
          color = Colors.red;
        } else {
          icon = Icons.close_fullscreen;
          color = Colors.orange;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                height: 160,
                width: 160,
                child: Icon(icon, size: 90, color: color),
              ),
              const SizedBox(height: 20),
              Text(
                'Window is ${state.isOpen ? "Open" : "Closed"}',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                state.isLocked ? "Locked" : "Unlocked",
                style: TextStyle(fontSize: 16, color: color.withOpacity(0.7)),
              ),
              const SizedBox(height: 20),
              if (state.dirt != Dirt.none) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.brown.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.brown),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Colors.brown),
                      const SizedBox(width: 8),
                      Text(
                        'Dirty: ${state.dirt.name}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.brown),
                      ),
                    ],
                  ),
                ),
                isIOS
                    ? CupertinoButton.filled(
                        onPressed: () {
                          context.read<SmartWindowStatusBloc>().add(
                                SetSmartWindowStatusEvent(
                                  isOpen: state.isOpen,
                                  isLocked: state.isLocked,
                                  dirtList: state.dirtList,
                                  dirt: Dirt.none,
                                ),
                              );
                        },
                        child: Text(AppLocalizations.of(context).cleanWindow),
                      )
                    : ElevatedButton.icon(
                        icon: const Icon(Icons.cleaning_services),
                        onPressed: () {
                          context.read<SmartWindowStatusBloc>().add(
                                SetSmartWindowStatusEvent(
                                  isOpen: state.isOpen,
                                  isLocked: state.isLocked,
                                  dirtList: state.dirtList,
                                  dirt: Dirt.none,
                                ),
                              );
                        },
                        label: Text(AppLocalizations.of(context).cleanWindow),
                      ),
                const SizedBox(height: 20),
              ],
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  isIOS
                      ? CupertinoButton(
                          onPressed: () {
                            context.read<SmartWindowStatusBloc>().add(
                                  ToggleSmartWindowStatusEvent(),
                                );
                          },
                          child: Text(AppLocalizations.of(context).openClose),
                        )
                      : ElevatedButton.icon(
                          icon: Icon(
                              state.isOpen ? Icons.close : Icons.open_in_new),
                          onPressed: () {
                            context.read<SmartWindowStatusBloc>().add(
                                  ToggleSmartWindowStatusEvent(),
                                );
                          },
                          label: Text(AppLocalizations.of(context).openClose),
                        ),
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
                          child: Text(AppLocalizations.of(context).lockUnlock),
                        )
                      : ElevatedButton.icon(
                          icon: Icon(
                              state.isLocked ? Icons.lock_open : Icons.lock),
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
