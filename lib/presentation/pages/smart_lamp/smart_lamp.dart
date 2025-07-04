import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_control_panel/presentation/widget/lamp/lamp_widget.dart';

class SmartLamp extends StatefulWidget {
  const SmartLamp({super.key});

  @override
  State<StatefulWidget> createState() => _SmartLampState();
}

class _SmartLampState extends State<SmartLamp> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Smart Lamp'),
        ),
        child: SafeArea(
          child: Center(
            child: LampWidget(),
          ),
        ),
      );
    } else {
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
}
