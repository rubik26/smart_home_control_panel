import 'package:flutter/material.dart';
import 'package:smart_home_control_panel/presentation/widget/lang/lang.dart';

class SelectedLang extends StatelessWidget {
  const SelectedLang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Language'),
      ),
      body: Center(child: Lang()),
    );
  }
}
