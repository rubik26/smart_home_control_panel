import 'package:flutter/material.dart';
import 'package:smart_home_control_panel/presentation/pages/settings/setting.dart';
import 'package:smart_home_control_panel/presentation/pages/smart_lamp/smart_lamp.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Panel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Setting(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SmartLamp(),
                    ),
                  );
                },
                child: const Text('Smart Lamp'),
              ),
            ),
            const SizedBox(height: 300),
            Text(
              'in progress',
              style: TextStyle(fontSize: 60),
            )
          ],
        ),
      ),
    );
  }
}
