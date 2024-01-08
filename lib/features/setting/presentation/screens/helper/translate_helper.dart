import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import '../../../../../core/utils/extension/string_ext.dart';
import '../../../../../core/utils/pair.dart';
import '../../../../../generated/locale_keys.g.dart';

class TranslateAvailable {
  final BuildContext context;

  const TranslateAvailable(this.context);

  List<Pair<Locale, String>> get application {
    return [
      Pair(
        context.deviceLocale,
        LocaleKeys.deviceLanguage.tr(),
      ),
      Pair(
        const Locale('en'),
        LocaleNames.of(context)?.nameOf('en') ?? emptyString,
      ),
      Pair(
        const Locale('id'),
        LocaleNames.of(context)?.nameOf('id') ?? emptyString,
      ),
    ];
  }

  List<Pair<Locale, String>> get quran {
    return [
      Pair(
        context.deviceLocale,
        LocaleKeys.deviceLanguage.tr(),
      ),
      Pair(
        const Locale('en'),
        LocaleNames.of(context)?.nameOf('en') ?? emptyString,
      ),
      Pair(
        const Locale('id'),
        LocaleNames.of(context)?.nameOf('id') ?? emptyString,
      ),
    ];
  }

  List<Pair<Locale, String>> get latin {
    return [
      Pair(
        context.deviceLocale,
        LocaleKeys.deviceLanguage.tr(),
      ),
      Pair(
        const Locale('en'),
        LocaleNames.of(context)?.nameOf('en') ?? emptyString,
      ),
      Pair(
        const Locale('id'),
        LocaleNames.of(context)?.nameOf('id') ?? emptyString,
      ),
    ];
  }

  List<Pair<Locale, String>> get prayer {
    return [
      const Pair(
        Locale('en'),
        "Fajr, Dhuhr, Asr, Maghrib, Isha",
      ),
      const Pair(Locale('id'), "Subuh (Fajr), Dzuhur, Ashar, Maghrib, Isya"),
      // Arabic
      const Pair(
        Locale('ar'),
        "الفجر, الظهر, العصر, المغرب, العشاء",
      ),
      // Azerbaijani
      const Pair(
        Locale('az'),
        "Fəcr, Zöhr, Əsr, Məğrib, Axşam",
      ),
      // Dansk
      const Pair(
        Locale('da'),
        "Fajr, Dhuhr, Asr, Maghrib, Isha'a",
      ),
      // Deutsch-land
      const Pair(
        Locale('de'),
        "Fadschr, Zuhr, Asr, Maghrib, Isha",
      ),
      // French
      const Pair(
        Locale('fr'),
        "Sobh (Fajr), Dohr, Asr, Maghreb, Icha",
      ),
      // Malay
      const Pair(
        Locale('ms'),
        "Subuh (Fajr), Zohor, Asar, Maghrib, Isyak",
      ),
      // Turkish
      const Pair(
        Locale('tr'),
        "Sabah (Fajr), Öğle, İkindi, Akşam, Yatsı",
      ),
      // Russian
      const Pair(
        Locale('ru'),
        "Фаджр, Зухр, Аср, Магриб, Иша",
      ),
    ];
  }
}

extension TranslateHelper on BuildContext {
  String defaultLanguageFor(Locale? locale) {
    // Get the name of the provided locale
    final localeName =
        LocaleNames.of(this)?.nameOf(locale?.languageCode ?? emptyString);

    // If the name of the provided locale is null, get the name of the current locale
    final languageCodeName =
        localeName ?? LocaleNames.of(this)?.nameOf(this.locale.languageCode);

    // If both are null, return an empty string
    final finalName = languageCodeName ?? emptyString;

    return finalName;
  }

  List<Pair<Locale, String>> get supportTranslateApplication {
    return TranslateAvailable(this).application;
  }

  List<Pair<Locale, String>> get supportTranslateQuran {
    return TranslateAvailable(this).quran;
  }

  List<Pair<Locale, String>> get supportTranslateLatin {
    return TranslateAvailable(this).latin;
  }

  List<Pair<Locale, String>> get supportTranslatePrayerTime {
    return TranslateAvailable(this).prayer;
  }
}
