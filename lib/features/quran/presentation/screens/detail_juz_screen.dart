import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/extension/dartz_ext.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/features/bookmark/domain/entities/juz_bookmark.codegen.dart';
import 'package:quranku/features/quran/presentation/screens/components/verses_list.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../core/components/loading_screen.dart';
import '../../domain/entities/juz.codegen.dart';
import '../bloc/detailJuz/detail_juz_bloc.dart';
import 'components/app_bar_detail_screen.dart';

class DetailJuzScreen extends StatelessWidget {
  final JuzConstant? juz;

  const DetailJuzScreen({Key? key, this.juz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final juzDetailBloc = context.read<JuzDetailBloc>();
    return Scaffold(
      body: BlocConsumer<JuzDetailBloc, JuzDetailState>(
        listener: (context, state) {
          if (state.saveBookmarkResult?.isLeft() ?? false) {
            final message = state.saveBookmarkResult?.asLeft().message;
            context.showErrorToast(message ?? emptyString);
          } else if (state.deleteBookmarkResult?.isLeft() ?? false) {
            final message = state.saveBookmarkResult?.asLeft().message;
            context.showErrorToast(message ?? emptyString);
          } else if (state.saveVerseBookmarkResult?.isRight() ?? false) {
            final verseNumber = state.saveVerseBookmarkResult?.asRight();
            context
                .showInfoToast(LocaleKeys.successAddingVersesBookmark.tr(args: [
              juz?.name ?? emptyString,
              verseNumber ?? emptyString,
            ]));
          } else if (state.deleteVerseBookmarkResult?.isRight() ?? false) {
            final verseNumber = state.deleteVerseBookmarkResult?.asRight();
            context.showInfoToast(
                LocaleKeys.successRemovingVersesBookmark.tr(args: [
              juz?.name ?? emptyString,
              verseNumber ?? emptyString,
            ]));
          } else if (state.saveVerseBookmarkResult?.isLeft() ?? false) {
            final message = state.saveVerseBookmarkResult?.asLeft().message;
            context.showErrorToast(message ?? emptyString);
          } else if (state.deleteVerseBookmarkResult?.isLeft() ?? false) {
            final message = state.deleteVerseBookmarkResult?.asLeft().message;
            context.showErrorToast(message ?? emptyString);
          }
        },
        builder: (context, state) {
          final detailJuz = state.detailJuzResult?.asRight();
          return NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBarDetailScreen(
                  title: juz?.name ?? emptyString,
                  isBookmarked: detailJuz?.isBookmarked ?? false,
                  onPressedBookmark: (state.detailJuzResult?.isRight() ?? false)
                      ? () {
                          final juzBookmark = JuzBookmark(
                            number: juz?.number ?? 0,
                            name: juz?.name ?? emptyString,
                            description: juz?.description ?? emptyString,
                          );
                          juzDetailBloc.add(
                            OnPressedBookmarkEvent(
                              juzBookmark: juzBookmark,
                              isBookmarked: detailJuz?.isBookmarked ?? false,
                            ),
                          );
                        }
                      : null,
                ),
              ];
            },
            body: BlocBuilder<JuzDetailBloc, JuzDetailState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LoadingScreen();
                } else if (state.detailJuzResult?.isRight() ?? false) {
                  final verses = detailJuz?.verses;

                  return VersesList(
                    clickFrom: ClickFrom.juz,
                    listVerses: verses ?? [],
                    juz: juz,
                  );
                } else if (state.detailJuzResult?.isLeft() ?? false) {
                  final message = state.detailJuzResult?.asLeft().message;
                  return Center(child: Text('$message'));
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
