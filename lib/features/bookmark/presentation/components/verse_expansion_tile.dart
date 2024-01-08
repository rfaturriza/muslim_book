import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/color.dart';
import 'package:quranku/features/bookmark/domain/entities/verse_bookmark.codegen.dart';
import 'package:quranku/features/quran/domain/entities/surah_name.codegen.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../core/constants/font_constants.dart';
import '../../../../core/utils/extension/string_ext.dart';
import '../bloc/bookmark/bookmark_bloc.dart';

class VerseExpansionTile extends StatelessWidget {
  final bool isExpanded;
  final List<VerseBookmark> listVerse;
  final Function(VerseBookmark) onTapVerse;

  const VerseExpansionTile({
    super.key,
    this.isExpanded = false,
    required this.listVerse,
    required this.onTapVerse,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: secondaryColor.shade500,
      collapsedBackgroundColor: secondaryColor.shade500,
      initiallyExpanded: isExpanded,
      trailing: isExpanded
          ? Icon(
              Icons.expand_circle_down,
              color: defaultColor.shade300,
            )
          : RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.expand_circle_down_outlined,
                color: defaultColor.shade300,
              ),
            ),
      onExpansionChanged: (value) {
        context.read<BookmarkBloc>().add(
              BookmarkEvent.onChangedExpansionPanel(
                index: BookmarkPanelConstant.verses,
                isExpanded: value,
              ),
            );
      },
      title: Text(
        LocaleKeys.verses.tr(),
        style: context.textTheme.titleMedium?.copyWith(
          color: defaultColor.shade300,
        ),
      ),
      children: [
        ...listVerse.map(
          (e) => VerseBookmarkListTile(
            onTapVerse: () => onTapVerse(e),
            surahName: e.surahName,
            juzName: e.juz?.name,
            verseNumber: e.versesNumber.inSurah ?? 0,
            backgroundColor: context.theme.colorScheme.background,
          ),
        ),
      ],
    );
  }
}

class VerseBookmarkListTile extends StatelessWidget {
  final Function() onTapVerse;
  final SurahName? surahName;
  final String? juzName;
  final int verseNumber;
  final Color? backgroundColor;

  const VerseBookmarkListTile({
    super.key,
    required this.onTapVerse,
    this.surahName,
    this.juzName,
    required this.verseNumber,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final name = () {
      if (surahName != null) {
        return surahName!.transliteration?.asLocale(context.locale) ??
            emptyString;
      } else if (juzName != null) {
        return juzName ?? emptyString;
      } else {
        return emptyString;
      }
    }();

    return Container(
      color: backgroundColor,
      child: ListTile(
        onTap: onTapVerse,
        title: Text(
          name,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${LocaleKeys.verses} $verseNumber',
          style: context.textTheme.bodyMedium,
        ),
        trailing: () {
          if (surahName != null) {
            return Text(
              surahName?.short ?? emptyString,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: defaultColor.shade50,
                fontFamily: FontConst.decoTypeThuluthII,
                fontSize: 25,
              ),
            );
          }
        }(),
      ),
    );
  }
}
