import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_control_panel/l10n/app_localizations.dart';
import 'package:smart_home_control_panel/presentation/bloc/locale_cubit.dart';

class Lang extends StatelessWidget {
  const Lang({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLangCode = context.watch<LocaleCubit>().state.languageCode;

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: currentLangCode,
        onChanged: (String? newLang) {
          if (newLang != null) {
            context.read<LocaleCubit>().switchLocale(Locale(newLang));
          }
        },
        items: [
          DropdownMenuItem(
            value: 'en',
            child: Row(
              children: [
                Icon(Icons.language, color: Colors.blue),
                SizedBox(width: 8),
                Text(AppLocalizations.of(context).languageOptionEnglish)
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'hy',
            child: Row(
              children: [
                Icon(Icons.language, color: Colors.redAccent),
                SizedBox(width: 8),
                Text(AppLocalizations.of(context).languageOptionArmenian),
              ],
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        dropdownColor: Theme.of(context).cardColor,
        style: Theme.of(context).textTheme.bodyMedium,
        icon: const Icon(Icons.arrow_drop_down),
      ),
    );
  }
}
