import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quranku/core/network/networkInfo/network_info_bloc.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/theme.dart';
import 'package:quranku/features/quran/presentation/bloc/juz/juz_cubit.dart';
import 'package:quranku/features/quran/presentation/screens/quran_screen.dart';
import 'package:quranku/features/shalat/presentation/bloc/shalat/shalat_bloc.dart';
import 'package:quranku/generated/locale_keys.g.dart';
import 'package:quranku/injection.dart';

import 'features/quran/presentation/bloc/surah/surah_bloc.dart';
import 'features/setting/presentation/bloc/language_setting/language_setting_bloc.dart';
import 'features/setting/presentation/bloc/styling_setting/styling_setting_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkInfoBloc>(
          create: (context) => sl<NetworkInfoBloc>(),
        ),
        BlocProvider<SurahBloc>(
          create: (context) => sl<SurahBloc>()..add(const SurahFetchEvent()),
        ),
        BlocProvider<JuzBloc>(
          create: (context) => sl<JuzBloc>(),
        ),
        BlocProvider<ShalatBloc>(
          create: (context) => sl<ShalatBloc>()..add(ShalatEvent.init(locale)),
        ),
        BlocProvider<LanguageSettingBloc>(
          create: (context) => sl<LanguageSettingBloc>()
            ..add(const LanguageSettingEvent.getLatinLanguage())
            ..add(const LanguageSettingEvent.getPrayerLanguage())
            ..add(const LanguageSettingEvent.getQuranLanguage()),
        ),
        BlocProvider<StylingSettingBloc>(
          create: (context) => sl<StylingSettingBloc>()
            ..add(const StylingSettingEvent.getArabicFontFamily())
            ..add(const StylingSettingEvent.getLatinFontSize())
            ..add(const StylingSettingEvent.getArabicFontSize())
            ..add(const StylingSettingEvent.getTranslationFontSize()),
        ),
      ],
      child: OKToast(
        textAlign: TextAlign.center,
        textPadding: const EdgeInsets.all(10),
        radius: 5,
        position: ToastPosition.bottom,
        child: MaterialApp(
          title: LocaleKeys.appName.tr(),
          debugShowCheckedModeBanner: false,
          theme: themeData,
          localizationsDelegates: [
            for (var delegate in context.localizationDelegates) delegate,
            const LocaleNamesLocalizationsDelegate(),
          ],
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const ScaffoldConnection(),
        ),
      ),
    );
  }
}

class ScaffoldConnection extends StatelessWidget {
  const ScaffoldConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<NetworkInfoBloc, NetworkInfoState>(
        builder: (context, state) {
          if (state is NetworkInfoDisconnectedState) {
            return FloatingActionButton(
              onPressed: () {
                context.showErrorToast(
                  LocaleKeys.noInternetConnection.tr(),
                );
              },
              child: const Icon(Icons.signal_wifi_off_outlined),
            );
          }
          return const SizedBox();
        },
      ),
      body: const QuranScreen(),
    );
  }
}
