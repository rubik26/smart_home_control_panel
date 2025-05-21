import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_control_panel/presentation/bloc/theme_mode_bloc.dart';
import 'package:smart_home_control_panel/presentation/pages/selected_lang/selected_lang.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Settings'),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<ThemeModeBloc, bool>(
                builder: (context, state) {
                  return CupertinoFormRow(
                    prefix: const Text('Theme'),
                    helper: const Text('Light / Dark'),
                    child: CupertinoSwitch(
                      value: state,
                      onChanged: (value) {
                        context
                            .read<ThemeModeBloc>()
                            .add(ToggleThemeModeEvent());
                        print('Theme changed to ${state ? 'Dark' : 'Light'}');
                      },
                    ),
                  );
                },
              ),
              CupertinoListTile(
                title: const Text('Language'),
                trailing: const Icon(CupertinoIcons.forward),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const SelectedLang(),
                    ),
                  );
                },
                subtitle: const Text('English (in progress)'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24),
            ),
            const Divider(),
            BlocBuilder<ThemeModeBloc, bool>(
              builder: (context, state) {
                return ListTile(
                  title: const Text('Theme'),
                  subtitle: const Text('Light / Dark'),
                  trailing: Switch(
                    value: state,
                    onChanged: (value) {
                      context.read<ThemeModeBloc>().add(ToggleThemeModeEvent());
                      print('Theme changed to ${state ? 'Dark' : 'Light'}');
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Language'),
              subtitle: const Text('English (in progress)'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectedLang(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
