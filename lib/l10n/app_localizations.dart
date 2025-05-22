import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLocales = [
    Locale('en'),
    Locale('hy'),
  ];

  late final Map<String, String> _localizedStrings =
      _localizedValues[locale.languageCode]!;

  // Из твоих ARB и дополнительно для виджетов
  String get settingsTitle => _localizedStrings['settingsTitle']!;
  String get themeTitle => _localizedStrings['themeTitle']!;
  String get themeSubtitle => _localizedStrings['themeSubtitle']!;
  String get languageTitle => _localizedStrings['languageTitle']!;
  String get languageSubtitle => _localizedStrings['languageSubtitle']!;
  String get languageOptionEnglish =>
      _localizedStrings['languageOptionEnglish']!;
  String get languageOptionArmenian =>
      _localizedStrings['languageOptionArmenian']!;

  // Control Panel
  String get controlPanelTitle =>
      _localizedStrings['controlPanelTitle'] ?? 'Control Panel';
  String get smartLamp => _localizedStrings['smartLamp'] ?? 'Smart Lamp';
  String get smartDoor => _localizedStrings['smartDoor'] ?? 'Smart Door';
  String get smartWindow => _localizedStrings['smartWindow'] ?? 'Smart Window';
  String get inProgress => _localizedStrings['inProgress'] ?? 'in progress';

  // Smart Window
  String windowStatusOpen() => _localizedStrings['windowStatusOpen'] ?? 'Open';
  String windowStatusClosed() =>
      _localizedStrings['windowStatusClosed'] ?? 'Closed';
  String windowLocked() => _localizedStrings['windowLocked'] ?? 'Locked';
  String windowUnlocked() => _localizedStrings['windowUnlocked'] ?? 'Unlocked';
  String get dirty => _localizedStrings['dirty'] ?? 'Dirty';
  String get cleanWindow => _localizedStrings['cleanWindow'] ?? 'Clean Window';
  String get openClose => _localizedStrings['openClose'] ?? 'Open / Close';
  String get lockUnlock => _localizedStrings['lockUnlock'] ?? 'Lock / Unlock';

  // Smart Door
  String doorOpen() => _localizedStrings['doorOpen'] ?? 'Open';
  String doorClosed() => _localizedStrings['doorClosed'] ?? 'Closed';
  String doorLockEnabled() => _localizedStrings['doorLockEnabled'] ?? 'Enabled';
  String doorLockDisabled() =>
      _localizedStrings['doorLockDisabled'] ?? 'Disabled';
  String get doorOpenClose =>
      _localizedStrings['doorOpenClose'] ?? 'Open / Close';
  String get doorLockUnlock =>
      _localizedStrings['doorLockUnlock'] ?? 'Lock / Unlock';

  // Smart Lamp
  String powerLevelLabel(int level) =>
      _localizedStrings['powerLevel$level'] ?? 'Power Level $level';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hy'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Пример Map для строк
const Map<String, Map<String, String>> _localizedValues = {
  'en': {
    'settingsTitle': 'Settings',
    'themeTitle': 'Theme',
    'themeSubtitle': 'Light / Dark',
    'languageTitle': 'Language',
    'languageSubtitle': 'English',
    'languageOptionEnglish': 'English',
    'languageOptionArmenian': 'Armenian',

    'controlPanelTitle': 'Control Panel',
    'smartLamp': 'Smart Lamp',
    'smartDoor': 'Smart Door',
    'smartWindow': 'Smart Window',
    'inProgress': 'in progress',

    'windowStatusOpen': 'Open',
    'windowStatusClosed': 'Closed',
    'windowLocked': 'Locked',
    'windowUnlocked': 'Unlocked',
    'dirty': 'Dirty',
    'cleanWindow': 'Clean Window',
    'openClose': 'Open / Close',
    'lockUnlock': 'Lock / Unlock',

    'doorOpen': 'Open',
    'doorClosed': 'Closed',
    'doorLockEnabled': 'Enabled',
    'doorLockDisabled': 'Disabled',
    'doorOpenClose': 'Open / Close',
    'doorLockUnlock': 'Lock / Unlock',

    // Можно добавить power level, но пока не обязательно
  },
  'hy': {
    'settingsTitle': 'Կարգավորումներ',
    'themeTitle': 'Թեմա',
    'themeSubtitle': 'Բաց / Մութ',
    'languageTitle': 'Լեզու',
    'languageSubtitle': 'Հայերեն',
    'languageOptionEnglish': 'Անգլերեն',
    'languageOptionArmenian': 'Հայերեն',
    'controlPanelTitle': 'Կառավարման վահանակ',
    'smartLamp': 'Խելացի Լամպ',
    'smartDoor': 'Խելացի Դուռ',
    'smartWindow': 'Խելացի Տուհան',
    'inProgress': 'աշխատում ենք',
    'windowStatusOpen': 'Բաց',
    'windowStatusClosed': 'Փակ',
    'windowLocked': 'Փակված',
    'windowUnlocked': 'Բաց',
    'dirty': 'Մաքուր չէ',
    'cleanWindow': 'Մաքրել Տուհանը',
    'openClose': 'Բացել / Փակել',
    'lockUnlock': 'Փակել / Բացել',
    'doorOpen': 'Բաց',
    'doorClosed': 'Փակ',
    'doorLockEnabled': 'Ընթեռնելի',
    'doorLockDisabled': 'Չեղարկված',
    'doorOpenClose': 'Բացել / Փակել',
    'doorLockUnlock': 'Փակել / Բացել',
  }
};
