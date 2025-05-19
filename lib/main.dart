import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_home_control_panel/data/repositories_impl/smart_lamp_repo_impl.dart';
import 'package:smart_home_control_panel/data/repositories_impl/theme_mode_repo_impl.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_lamp_power.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_theme.dart';
import 'package:smart_home_control_panel/presentation/bloc/smart_lamp_mode_bloc.dart';
import 'package:smart_home_control_panel/presentation/bloc/theme_mode_bloc.dart';
import 'package:smart_home_control_panel/presentation/pages/control_panel.dart';

void main() async {
  await GetStorage.init();
  ToggleTheme toggleTheme = ToggleTheme(
    themeModeRepo: ThemeModeRepoImpl(),
  );
  ToggleLampPower toggleLampPower =
      ToggleLampPower(smartLampRepo: SmartLampRepoImpl());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeModeBloc(toggleTheme)),
        BlocProvider(create: (_) => SmartLampModeBloc(toggleLampPower)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final themeRepo = ThemeModeRepoImpl();
  late final toggleTheme = ToggleTheme(themeModeRepo: themeRepo);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeModeBloc(toggleTheme),
      child: BlocBuilder<ThemeModeBloc, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Control Panel',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: ControlPanel(),
          );
        },
      ),
    );
  }
}
