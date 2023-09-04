import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/components/loading_screen.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/bookmark/domain/entities/surah_bookmark.codegen.dart';
import 'package:quranku/features/quran/presentation/screens/components/app_bar_detail_screen.dart';
import 'package:quranku/features/quran/presentation/screens/components/verses_list.dart';

import '../../../../generated/locale_keys.g.dart';
import '../bloc/detailSurah/detail_surah_bloc.dart';

class DetailSurahScreen extends StatelessWidget {
  final String? surahName;
  final int? jumpToVerse;

  const DetailSurahScreen({Key? key, this.surahName, this.jumpToVerse,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final surahDetailBloc = context.read<SurahDetailBloc>();
    return Scaffold(
      body: BlocConsumer<SurahDetailBloc, SurahDetailState>(
        listener: (context, state) {
          if (state.saveBookmarkResult?.isLeft() ?? false) {
            final message = state.saveBookmarkResult
                ?.asLeft()
                .message;
            context.showErrorToast(message ?? emptyString);
          } else if (state.deleteBookmarkResult?.isLeft() ?? false) {
            final message = state.saveBookmarkResult
                ?.asLeft()
                .message;
            context.showErrorToast(message ?? emptyString);
          } else if (state.saveVerseBookmarkResult?.isRight() ?? false) {
            final verseNumber = state.saveVerseBookmarkResult?.asRight();
            context
                .showInfoToast(LocaleKeys.successAddingVersesBookmark.tr(args: [
              surahName ?? emptyString,
              verseNumber ?? emptyString,
            ]));
          } else if (state.deleteVerseBookmarkResult?.isRight() ?? false) {
            final verseNumber = state.deleteVerseBookmarkResult?.asRight();
            context.showInfoToast(
                LocaleKeys.successRemovingVersesBookmark.tr(args: [
                  surahName ?? emptyString,
                  verseNumber ?? emptyString,
                ]));
          } else if (state.saveVerseBookmarkResult?.isLeft() ?? false) {
            final message = state.saveVerseBookmarkResult
                ?.asLeft()
                .message;
            context.showErrorToast(message ?? emptyString);
          } else if (state.deleteVerseBookmarkResult?.isLeft() ?? false) {
            final message = state.deleteVerseBookmarkResult
                ?.asLeft()
                .message;
            context.showErrorToast(message ?? emptyString);
          }
        },
        builder: (context, state) {
          final detailSurah = state.detailSurahResult?.asRight();
          return NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBarDetailScreen(
                  isBookmarked: detailSurah?.isBookmarked ?? false,
                  title: surahName ?? emptyString,
                  onPressedBookmark: (state.detailSurahResult?.isRight() ??
                      false)
                      ? () {
                    final detailSurah =
                    state.detailSurahResult?.asRight();
                    final surahBookmark = SurahBookmark(
                      surahName: detailSurah!.name!,
                      surahNumber: detailSurah.number!,
                      revelation: detailSurah.revelation!,
                      totalVerses: detailSurah.numberOfVerses ?? 0,
                    );
                    surahDetailBloc.add(
                      OnPressedBookmarkEvent(
                        surahBookmark: surahBookmark,
                        isBookmarked: detailSurah.isBookmarked ?? false,
                      ),
                    );
                  }
                      : null,
                ),
              ];
            },
            body: BlocBuilder<SurahDetailBloc, SurahDetailState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LoadingScreen();
                } else if (state.detailSurahResult?.isRight() ?? false) {
                  final verses = detailSurah?.verses;

                  return VersesList(
                    toVerses: jumpToVerse,
                    clickFrom: ClickFrom.surah,
                    listVerses: verses ?? [],
                    surah: detailSurah,
                    preBismillah: detailSurah?.preBismillah?.text?.arab,
                  );
                } else if (state.detailSurahResult?.isLeft() ?? false) {
                  final failure = state.detailSurahResult?.asLeft();
                  return Center(child: Text('${failure?.message}'));
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }
}
