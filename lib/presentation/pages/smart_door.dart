import 'package:flutter/material.dart';
import 'package:smart_home_control_panel/presentation/widget/smart_door/smart_door_widget.dart';

class SmartDoor extends StatelessWidget {
  const SmartDoor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Door'),
      ),
      body: Center(child: SmartDoorWidget()),
    );
  }
}
