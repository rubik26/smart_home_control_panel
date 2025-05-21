import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_control_panel/presentation/bloc/smart_lamp_mode_bloc.dart';

class LampWidget extends StatefulWidget {
  const LampWidget({super.key});

  @override
  State<LampWidget> createState() => _LampWidgetState();
}

class _LampWidgetState extends State<LampWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartLampModeBloc, int>(
      builder: (context, powerLevel) {
        Color bulbColor;
        switch (powerLevel) {
          case 0:
            bulbColor = Colors.grey;
            break;
          case 1:
            bulbColor = Colors.yellow.shade200;
            break;
          case 2:
            bulbColor = Colors.yellow.shade300;
            break;
          case 3:
            bulbColor = Colors.yellow.shade400;
            break;
          case 4:
            bulbColor = Colors.yellow.shade500;
            break;
          case 5:
            bulbColor = Colors.yellow.shade600;
            break;
          case 6:
            bulbColor = Colors.yellow.shade700;
            break;
          default:
            bulbColor = Colors.grey;
        }

        final slider = Platform.isIOS
            ? CupertinoSlider(
                value: powerLevel.toDouble(),
                min: 0,
                max: 6,
                divisions: 6,
                onChanged: (value) {
                  context
                      .read<SmartLampModeBloc>()
                      .add(SetPowerLevelEvent(value.toInt()));
                },
              )
            : Slider(
                value: powerLevel.toDouble(),
                min: 0,
                max: 6,
                divisions: 6,
                label: '$powerLevel',
                onChanged: (value) {
                  context
                      .read<SmartLampModeBloc>()
                      .add(SetPowerLevelEvent(value.toInt()));
                },
              );

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lightbulb, size: 200, color: bulbColor),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: slider,
            ),
          ],
        );
      },
    );
  }
}
