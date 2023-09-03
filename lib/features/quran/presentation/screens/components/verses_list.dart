import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/core/constants/font_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/bookmark/domain/entities/verse_bookmark.codegen.dart';
import 'package:quranku/features/quran/domain/entities/juz.codegen.dart';
import 'package:quranku/features/quran/domain/entities/verses.codegen.dart';
import 'package:quranku/features/quran/presentation/bloc/detailJuz/detail_juz_bloc.dart';
import 'package:quranku/features/quran/presentation/screens/components/verse_popup_menu.dart';

import '../../../../../core/utils/extension/string_ext.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../domain/entities/detail_surah.codegen.dart';
import '../../bloc/detailSurah/detail_surah_bloc.dart';
import 'number_pin.dart';

enum ClickFrom {
  juz,
  surah,
  bookmark,
}

class VersesList extends StatelessWidget {
  final ClickFrom clickFrom;
  final String? preBismillah;
  final JuzConstant? juz;
  final DetailSurah? surah;
  final List<Verses> listVerses;

  const VersesList({
    super.key,
    required this.listVerses,
    this.preBismillah,
    required this.clickFrom,
    this.juz,
    this.surah,
  });

  @override
  Widget build(BuildContext context) {
    final isPreBismillah = preBismillah?.isNotEmpty == true;
    return ListView.separated(
      itemCount: () {
        if (isPreBismillah) {
          return listVerses.length + 1;
        }
        return listVerses.length;
      }(),
      separatorBuilder: (BuildContext context, int index) {
        if (isPreBismillah && index == 0) {
          return const Divider(color: Colors.transparent);
        }
        return Divider(color: secondaryColor.shade500, thickness: 0.1);
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
        final verses =
            isPreBismillah ? listVerses[index - 1] : listVerses[index];
        return ListTileVerses(
          verses: verses,
          clickFrom: clickFrom,
          juz: juz,
          surah: surah,
        );
      },
    );
  }
}

class ListTileVerses extends StatelessWidget {
  final ClickFrom clickFrom;
  final Verses verses;
  final JuzConstant? juz;
  final DetailSurah? surah;

  const ListTileVerses({
    super.key,
    required this.verses,
    required this.clickFrom,
    this.juz,
    this.surah,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: FittedBox(
                  child: NumberPin(
                    number: verses.number?.inSurah.toString() ?? emptyString,
                  ),
                ),
              ),
              Expanded(
                child: VersePopupMenuButton(
                  isBookmarked: verses.isBookmarked,
                  onBookmarkPressed: () {
                    if (clickFrom == ClickFrom.surah) {
                      final surahDetailBloc = context.read<SurahDetailBloc>();
                      if (surah == null) return;
                      surahDetailBloc.add(
                        SurahDetailEvent.onPressedVerseBookmark(
                          bookmark: VerseBookmark(
                            surahName: surah!.name!,
                            versesNumber: verses.number!,
                          ),
                          isBookmarked: verses.isBookmarked ?? false,
                        ),
                      );
                    } else {
                      final juzDetailBloc = context.read<JuzDetailBloc>();
                      juzDetailBloc.add(
                        JuzDetailEvent.onPressedVerseBookmark(
                          bookmark: VerseBookmark(
                            juz: JuzConstant(
                              name: juz?.name ?? emptyString,
                              number: juz?.number ?? 0,
                              description: juz?.description ?? emptyString,
                            ),
                            versesNumber: verses.number!,
                          ),
                          isBookmarked: verses.isBookmarked ?? false,
                        ),
                      );
                    }
                  },
                ),
              )
            ],
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
    } else if (isIndonesia &&
        verses.text?.transliteration?.id?.isNotEmpty == true) {
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
