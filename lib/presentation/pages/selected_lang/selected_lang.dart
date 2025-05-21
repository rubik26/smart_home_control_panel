import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_control_panel/presentation/widget/lang/lang.dart';

class SelectedLang extends StatelessWidget {
  const SelectedLang({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Selected Language'),
        ),
        child: SafeArea(
          child: Center(child: Lang()),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Selected Language'),
        ),
        body: Center(child: Lang()),
      );
    }
  }
}
