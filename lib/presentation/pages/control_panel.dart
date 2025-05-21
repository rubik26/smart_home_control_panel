import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_control_panel/presentation/pages/settings/setting.dart';
import 'package:smart_home_control_panel/presentation/pages/smart_door.dart';
import 'package:smart_home_control_panel/presentation/pages/smart_lamp/smart_lamp.dart';
import 'package:smart_home_control_panel/presentation/pages/window/window.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Control Panel'),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.settings),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => const Setting()),
              );
            },
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: CupertinoButton.filled(
                    child: const Text('Smart Lamp'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (_) => const SmartLamp()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: CupertinoButton.filled(
                    child: const Text('Smart Door'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (_) => const SmartDoor()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: CupertinoButton.filled(
                    child: const Text('Smart Window'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (_) => const Window()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 300),
                const Text(
                  'in progress',
                  style: TextStyle(fontSize: 60),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Control Panel'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Setting()),
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
                      MaterialPageRoute(builder: (_) => const SmartLamp()),
                    );
                  },
                  child: const Text('Smart Lamp'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SmartDoor()),
                    );
                  },
                  child: const Text('Smart Door'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Window()),
                    );
                  },
                  child: const Text('Smart Window'),
                ),
              ),
              const SizedBox(height: 300),
              const Text(
                'in progress',
                style: TextStyle(fontSize: 60),
              ),
            ],
          ),
        ),
      );
    }
  }
}
