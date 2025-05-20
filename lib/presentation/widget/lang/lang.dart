import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_control_panel/presentation/bloc/locale_cubit.dart';

class Lang extends StatelessWidget {
  const Lang({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLangCode = context.watch<LocaleCubit>().state.languageCode;

    return DropdownButton<String>(
      value: currentLangCode,
      onChanged: (String? newLang) {
        if (newLang != null) {
          context.read<LocaleCubit>().switchLocale(Locale(newLang));
        }
      },
      items: const [
        DropdownMenuItem(value: 'en', child: Text('English')),
        DropdownMenuItem(value: 'hy', child: Text('Հայերեն')),
      ],
    );
  }
}
