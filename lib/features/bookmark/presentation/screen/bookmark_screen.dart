import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/features/bookmark/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:quranku/features/bookmark/presentation/components/background_verse.dart';
import 'package:quranku/features/bookmark/presentation/components/surah_expansion_tile.dart';
import 'package:quranku/features/bookmark/presentation/components/verse_expansion_tile.dart';
import 'package:quranku/features/quran/domain/entities/juz.codegen.dart';

import '../../../../core/utils/extension/string_ext.dart';
import '../../../../injection.dart';
import '../../../quran/domain/entities/surah.codegen.dart';
import '../../../quran/presentation/screens/components/juz_list.dart';
import '../../../quran/presentation/screens/components/surah_list.dart';
import '../components/juz_expansion_tile.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BookmarkBloc>(),
      child: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          return Stack(
            children: [
              const BackgroundVerse(),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SurahExpansionTile(
                        listSurah:
                            state.surahBookmarks?.getOrElse(() => []) ?? [],
                        isExpanded: state.isExpandedSurah,
                        onTapSurah: (surah) {
                          SurahList.onTapSurah(
                            context,
                            Surah(
                              number: surah.surahNumber,
                              name: surah.surahName,
                            ),
                          );
                        },
                      ),
                      const VSpacer(),
                      JuzExpansionTile(
                        listJuz: state.juzBookmarks?.getOrElse(() => []) ?? [],
                        isExpanded: state.isExpandedJuz,
                        onTapJuz: (juz) {
                          JuzList.onTapJuz(
                            context,
                            JuzConstant(
                              number: juz.number,
                              name: juz.name,
                              description: juz.description,
                            ),
                          );
                        },
                      ),
                      const VSpacer(),
                      VerseExpansionTile(
                        listVerse:
                            state.verseBookmarks?.getOrElse(() => []) ?? [],
                        isExpanded: state.isExpandedVerses,
                        onTapVerse: (verse) {
                          if(verse.surahName != null){
                            SurahList.onTapSurah(
                              context,
                              Surah(
                                number: verse.surahNumber,
                                name: verse.surahName,
                              ),
                              jumpToVerse: verse.versesNumber.inSurah,
                            );
                          } else {
                            JuzList.onTapJuz(
                              context,
                              JuzConstant(
                                number: verse.juz?.number ?? 0,
                                name: verse.juz?.name ?? emptyString,
                                description: verse.juz?.description ?? emptyString,
                              ),
                              jumpToVerse: verse.versesNumber.inQuran,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
