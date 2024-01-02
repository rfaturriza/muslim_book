import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/quran/presentation/screens/components/app_bar_detail_screen.dart';
import 'package:quranku/features/setting/presentation/screens/components/language_choose_bottom_sheet.dart';

import '../../../../core/utils/pair.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../injection.dart';
import '../bloc/setting/language_setting_bloc.dart';

class LanguageSettingScreen extends StatelessWidget {
  const LanguageSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LanguageSettingBloc>()
        ..add(const LanguageSettingEvent.getLatinLanguage())
        ..add(const LanguageSettingEvent.getPrayerLanguage())
        ..add(const LanguageSettingEvent.getQuranLanguage()),
      child: const _LanguageSettingScaffold(),
    );
  }
}

class _LanguageSettingScaffold extends StatelessWidget {
  const _LanguageSettingScaffold();

  @override
  Widget build(BuildContext context) {
    String defaultLanguageFor(Locale? locale) {
      return LocaleNames.of(context)?.nameOf(
            locale.toString(),
          ) ??
          LocaleNames.of(context)?.nameOf(
            context.locale.languageCode,
          ) ??
          emptyString;
    }

    return Scaffold(
      appBar: AppBarDetailScreen(title: LocaleKeys.language.tr()),
      body: BlocBuilder<LanguageSettingBloc, LanguageSettingState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Application Language'),
                subtitle: Text(
                  defaultLanguageFor(context.locale),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    enableDrag: true,
                    builder: (_) => BlocProvider.value(
                      value: context.read<LanguageSettingBloc>(),
                      child: LanguageChooseBottomSheet(
                        title: 'Application Language',
                        languages: [
                          Pair(context.deviceLocale, "Device Language"),
                          const Pair(Locale('en'), "English"),
                          const Pair(Locale('id'), "Bahasa Indonesia"),
                        ],
                        onTap: (Locale locale) {
                          context.setLocale(locale);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Quran Translation'),
                subtitle: Text(
                  defaultLanguageFor(state.localeQuran),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Latin Translation'),
                subtitle: Text(
                  defaultLanguageFor(state.localeLatin),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Prayer Time Language'),
                subtitle: Text(
                  defaultLanguageFor(state.localePrayerTime),
                ),
                onTap: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
