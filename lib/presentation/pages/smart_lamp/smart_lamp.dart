import 'package:flutter/material.dart';
import 'package:smart_home_control_panel/presentation/widget/lamp/lamp_widget.dart';

class SmartLamp extends StatefulWidget {
  const SmartLamp({super.key});

  @override
  State<StatefulWidget> createState() => _SmartLampState();
}

class _SmartLampState extends State<SmartLamp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Lamp'),
      ),
      body: Center(
        child: LampWidget(),
      ),
    );
  }
}
