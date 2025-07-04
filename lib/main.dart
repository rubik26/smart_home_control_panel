import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_home_control_panel/data/repositories_impl/smart_door_repo_impl.dart';
import 'package:smart_home_control_panel/data/repositories_impl/smart_lamp_repo_impl.dart';
import 'package:smart_home_control_panel/data/repositories_impl/smart_window_repo_impl.dart';
import 'package:smart_home_control_panel/data/repositories_impl/theme_mode_repo_impl.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_lamp_power.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_smart_door_status.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_smart_window_status.dart';
import 'package:smart_home_control_panel/domain/usecases/toggle_theme.dart';
import 'package:smart_home_control_panel/l10n/app_localizations.dart';
import 'package:smart_home_control_panel/presentation/bloc/locale_cubit.dart';
import 'package:smart_home_control_panel/presentation/bloc/smart_door_status_bloc.dart';
import 'package:smart_home_control_panel/presentation/bloc/smart_lamp_mode_bloc.dart';
import 'package:smart_home_control_panel/presentation/bloc/smart_window_status_bloc.dart';
import 'package:smart_home_control_panel/presentation/bloc/theme_mode_bloc.dart';
import 'package:smart_home_control_panel/presentation/pages/control_panel.dart';

void main() async {
  await GetStorage.init();

  ToggleTheme toggleTheme = ToggleTheme(
    themeModeRepo: ThemeModeRepoImpl(),
  );

  ToggleLampPower toggleLampPower = ToggleLampPower(
    smartLampRepo: SmartLampRepoImpl(),
  );

  ToggleSmartDoorStatus toggleSmartDoorStatus = ToggleSmartDoorStatus(
    repository: SmartDoorRepoImpl(),
  );

  ToggleSmartWindowStatus toggleSmartWindowStatus = ToggleSmartWindowStatus(
    repository: SmartWindowRepoImpl(),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeModeBloc(toggleTheme),
        ),
        BlocProvider(
          create: (_) => SmartLampModeBloc(toggleLampPower),
        ),
        BlocProvider(
          create: (_) => SmartDoorStatusBloc(toggleSmartDoorStatus),
        ),
        BlocProvider(
          create: (_) => LocaleCubit(),
        ),
        BlocProvider(
          create: (_) => SmartWindowStatusBloc(toggleSmartWindowStatus),
        ),
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
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('hy'),
            ],
            locale: context.watch<LocaleCubit>().state,
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
