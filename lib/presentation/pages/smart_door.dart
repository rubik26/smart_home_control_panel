import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_control_panel/presentation/widget/smart_door/smart_door_widget.dart';

class SmartDoor extends StatelessWidget {
  const SmartDoor({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Smart Door'),
        ),
        child: Center(child: SmartDoorWidget()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Smart Door'),
        ),
        body: Center(child: SmartDoorWidget()),
      );
    }
  }
}
