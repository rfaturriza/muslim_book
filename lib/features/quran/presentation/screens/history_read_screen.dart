import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/features/quran/presentation/bloc/lastRead/last_read_cubit.dart';
import 'package:quranku/features/quran/presentation/screens/components/app_bar_detail_screen.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../bookmark/presentation/components/verse_expansion_tile.dart';
import '../../domain/entities/juz.codegen.dart';
import '../../domain/entities/surah.codegen.dart';
import 'components/juz_list.dart';
import 'components/surah_list.dart';

class HistoryReadScreen extends StatelessWidget {
  const HistoryReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailScreen(title: LocaleKeys.readingHistory.tr()),
      body: BlocBuilder<LastReadCubit, LastReadState>(
        builder: (context, state) {
          final sortedSurah = state.lastReadSurah.toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          final sortedJuz = state.lastReadJuz.toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: LocaleKeys.surah.tr()),
                    Tab(text: LocaleKeys.juz.tr()),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(20.0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: sortedSurah.length,
                        itemBuilder: (context, index) {
                          return VerseBookmarkListTile(
                            surahName: sortedSurah[index].surahName,
                            onTapVerse: () {
                              SurahList.onTapSurah(
                                context,
                                Surah(
                                  number: sortedSurah[index].surahNumber,
                                  name: sortedSurah[index].surahName,
                                ),
                                jumpToVerse:
                                    sortedSurah[index].versesNumber.inSurah,
                              );
                            },
                            verseNumber:
                                sortedSurah[index].versesNumber.inSurah ?? 0,
                          );
                        },
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.all(20.0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: sortedJuz.length,
                        itemBuilder: (context, index) {
                          return VerseBookmarkListTile(
                            juzName: sortedJuz[index].name,
                            onTapVerse: () {
                              JuzList.onTapJuz(
                                context,
                                JuzConstant(
                                  number: sortedJuz[index].number,
                                  name: sortedJuz[index].name,
                                  description: sortedJuz[index].description,
                                ),
                                jumpToVerse:
                                    sortedJuz[index].versesNumber.inQuran,
                              );
                            },
                            verseNumber:
                                sortedJuz[index].versesNumber.inQuran ?? 0,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
