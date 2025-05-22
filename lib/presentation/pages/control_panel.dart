import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_control_panel/presentation/pages/settings/setting.dart';
import 'package:smart_home_control_panel/presentation/pages/smart_door.dart';
import 'package:smart_home_control_panel/presentation/pages/smart_lamp/smart_lamp.dart';
import 'package:smart_home_control_panel/presentation/pages/window/window.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  Widget _buildControlButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Widget page,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          Platform.isIOS
              ? CupertinoPageRoute(builder: (_) => page)
              : MaterialPageRoute(builder: (_) => page),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          width: double.infinity,
          child: Row(
            children: [
              Icon(icon,
                  size: 32, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 20),
              Text(
                label,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 30, bottom: 80),
      children: [
        _buildControlButton(
          context: context,
          icon: Icons.lightbulb_outline,
          label: 'Smart Lamp',
          page: const SmartLamp(),
        ),
        _buildControlButton(
          context: context,
          icon: Icons.door_front_door_outlined,
          label: 'Smart Door',
          page: const SmartDoor(),
        ),
        _buildControlButton(
          context: context,
          icon: Icons.window_outlined,
          label: 'Smart Window',
          page: const Window(),
        ),
        const SizedBox(height: 30),
        Center(
          child: Text(
            'in progress',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ],
    );
  }

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
        child: SafeArea(child: _buildContent(context)),
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
        body: _buildContent(context),
      );
    }
  }
}
