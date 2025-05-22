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

class _LampWidgetState extends State<LampWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartLampModeBloc, int>(
      builder: (context, powerLevel) {
        final isIOS = Platform.isIOS;

        // Цвет лампы в зависимости от яркости
        Color getBulbColor(int level) {
          if (level == 0) return Colors.grey;
          return HSLColor.fromAHSL(
                  1.0, 50, 1.0, (0.4 + level * 0.1).clamp(0.0, 1.0))
              .toColor();
        }

        final bulbColor = getBulbColor(powerLevel);

        final slider = isIOS
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bulbColor.withOpacity(0.1 + powerLevel * 0.1),
                boxShadow: powerLevel > 0
                    ? [
                        BoxShadow(
                          color: bulbColor.withOpacity(0.5),
                          blurRadius: 30 + powerLevel * 5,
                          spreadRadius: 10,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  Icons.lightbulb,
                  size: 120,
                  color: bulbColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Power Level: $powerLevel",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: bulbColor,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: slider,
            ),
          ],
        );
      },
    );
  }
}
