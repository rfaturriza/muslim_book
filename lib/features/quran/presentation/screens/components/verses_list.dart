import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/core/constants/font_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/quran/domain/entities/verses.codegen.dart';

import '../../../../../core/utils/extension/string_ext.dart';
import '../../../../../core/utils/themes/color.dart';
import 'number_pin.dart';

class VersesList extends StatelessWidget {
  final String? preBismillah;
  final List<Verses> listVerses;

  const VersesList({super.key, required this.listVerses, this.preBismillah});

  @override
  Widget build(BuildContext context) {
    final isPreBismillah = preBismillah?.isNotEmpty == true;
    return ListView.separated(
      itemCount: (){
        if(isPreBismillah){
          return listVerses.length + 1;
        }
        return listVerses.length;
      }(),
      separatorBuilder: (BuildContext context, int index) {
        if (isPreBismillah && index == 0) {
          return const Divider(color: Colors.transparent);
        }
        return Divider(color: secondaryColor.shade500,thickness: 0.1);
      },
      itemBuilder: (context, index) {
        if (index == 0 && isPreBismillah) {
          return Text(
            preBismillah ?? emptyString,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium?.copyWith(
              fontFamily: FontConst.lpmqIsepMisbah,
            ),
          );
        }
        final verses = isPreBismillah ? listVerses[index - 1] : listVerses[index];
        return ListTileVerses(verses: verses);
      },
    );
  }
}

class ListTileVerses extends StatelessWidget {
  final Verses verses;

  const ListTileVerses({super.key, required this.verses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: NumberPin(
            number: verses.number?.inSurah.toString() ?? emptyString,
          ),
          title: Text(
            verses.text?.arab ?? emptyString,
            textAlign: TextAlign.right,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontConst.lpmqIsepMisbah,
            ),
          ),
        ),
        const VSpacer(height: 8),
        TransliterationVerses(verses: verses),
        const VSpacer(height: 8),
        TranslationVerses(verses: verses),
      ],
    );
  }
}

class TranslationVerses extends StatelessWidget {
  final Verses verses;

  const TranslationVerses({super.key, required this.verses});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final isIndonesia = locale == const Locale('id');
    final isEnglish = locale == const Locale('en');
    if (isEnglish && verses.translation?.en?.isNotEmpty == true) {
      return ListTileTranslation(
        text: verses.translation?.en ?? emptyString,
        number: verses.number?.inSurah.toString() ?? emptyString,
      );
    } else if (isIndonesia && verses.translation?.id?.isNotEmpty == true) {
      return ListTileTranslation(
        text: verses.translation?.id ?? emptyString,
        number: verses.number?.inSurah.toString() ?? emptyString,
      );
    }
    return const Placeholder();
  }
}

class TransliterationVerses extends StatelessWidget {
  final Verses verses;

  const TransliterationVerses({super.key, required this.verses});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final isIndonesia = locale == const Locale('id');
    final isEnglish = locale == const Locale('en');
    if (isEnglish && verses.text?.transliteration?.en?.isNotEmpty == true) {
      return ListTileTransliteration(
        text: verses.text?.transliteration?.en ?? emptyString,
        number: verses.number?.inSurah.toString() ?? emptyString,
      );
    } else if (isIndonesia && verses.text?.transliteration?.id?.isNotEmpty == true) {
      return ListTileTransliteration(
        text: verses.text?.transliteration?.id ?? emptyString,
        number: verses.number?.inSurah.toString() ?? emptyString,
      );
    }
    return const SizedBox();
  }
}

class ListTileTranslation extends StatelessWidget {
  final String text;
  final String number;

  const ListTileTranslation(
      {super.key, required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w500,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number .', style: textStyle),
          const HSpacer(width: 8),
          Expanded(
            child: Text(
              text,
              style: textStyle,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}

class ListTileTransliteration extends StatelessWidget {
  final String text;
  final String number;

  const ListTileTransliteration(
      {super.key, required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.bodySmall?.copyWith(
      color: primaryColor.shade400,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number .', style: textStyle),
          const HSpacer(width: 8),
          Expanded(
            child: Text(
              text,
              style: textStyle,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
