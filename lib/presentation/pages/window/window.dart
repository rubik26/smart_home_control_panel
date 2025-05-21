import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_control_panel/presentation/widget/smart_window/smart_window_widget.dart';

class Window extends StatelessWidget {
  const Window({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Smart Window'),
        ),
        child: SafeArea(
          child: Center(
            child: SmartWindowWidget(),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Smart Window'),
        ),
        body: Center(
          child: SmartWindowWidget(),
        ),
      );
    }
  }
}
