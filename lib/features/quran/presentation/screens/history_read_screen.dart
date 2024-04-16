import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quranku/core/components/loading_screen.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/quran/presentation/bloc/lastRead/last_read_cubit.dart';
import 'package:quranku/features/quran/presentation/screens/components/app_bar_detail_screen.dart';
import 'package:quranku/generated/locale_keys.g.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../bookmark/presentation/components/verse_expansion_tile.dart';
import '../../domain/entities/juz.codegen.dart';
import '../../domain/entities/last_read_juz.codegen.dart';
import '../../domain/entities/last_read_surah.codegen.dart';
import '../../domain/entities/surah.codegen.dart';
import 'components/juz_list.dart';
import 'components/surah_list.dart';

class HistoryReadScreen extends StatefulWidget {
  const HistoryReadScreen({super.key});

  @override
  State<HistoryReadScreen> createState() => _HistoryReadScreenState();
}

class _HistoryReadScreenState extends State<HistoryReadScreen> {
  @override
  void initState() {
    super.initState();
    /// IGNORE THIS TEMPORARY
    // AdMobConst.showRewardedInterstitialAd(
    //   adUnitId: AdMobConst.rewardedInterstitialLastReadHistory,
    //   onEarnedReward: (_) {},
    //   onLoaded: () {},
    //   onFailedToLoad: (_) {},
    // );
  }

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
          return SafeArea(
            child: DefaultTabController(
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
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        if (state.statusSurah ==
                            FormzSubmissionStatus.inProgress) ...[
                          const LoadingScreen(),
                        ],
                        if (state.statusSurah !=
                            FormzSubmissionStatus.inProgress) ...[
                          ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            physics: const BouncingScrollPhysics(),
                            itemCount: sortedSurah.length,
                            itemBuilder: (context, index) {
                              return _SurahList(
                                surah: sortedSurah[index],
                              );
                            },
                          ),
                        ],
                        if (state.statusJuz ==
                            FormzSubmissionStatus.inProgress) ...[
                          const LoadingScreen(),
                        ],
                        if (state.statusJuz !=
                            FormzSubmissionStatus.inProgress) ...[
                          ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            physics: const BouncingScrollPhysics(),
                            itemCount: sortedJuz.length,
                            itemBuilder: (context, index) {
                              return _JuzList(
                                juz: sortedJuz[index],
                              );
                            },
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TimeInfo extends StatelessWidget {
  final double progress;

  final DateTime createdAt;

  const _TimeInfo({
    required this.progress,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: context.textTheme.bodySmall,
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    value: progress,
                    strokeCap: StrokeCap.round,
                  ),
                ],
              ),
              const HSpacer(width: 8),
              Text(
                '${DateFormat.yMMMMd(
                  context.locale.languageCode,
                ).format(
                  createdAt.toLocal(),
                )} - ${DateFormat.Hm(
                  context.locale.languageCode,
                ).format(
                  createdAt.toLocal(),
                )}',
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(width: 5),
          Text(
            timeago.format(
              createdAt,
              locale: context.locale.languageCode,
            ),
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SurahList extends StatelessWidget {
  final LastReadSurah surah;

  const _SurahList({
    required this.surah,
  });

  @override
  Widget build(BuildContext context) {
    final surahName =
        'Surah ${surah.surahName?.transliteration?.asLocale(context.locale)}';
    return _SwipeDeleteList(
      key: ValueKey(surah.createdAt),
      name: surahName,
      onDelete: () {
        context.read<LastReadCubit>().deleteLastReadSurah(
              surah.createdAt,
            );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          SurahList.onTapSurah(
            context,
            Surah(
              number: surah.surahNumber,
              name: surah.surahName,
            ),
            jumpToVerse: surah.versesNumber.inSurah,
          );
        },
        title: VerseBookmarkListTile(
          surahName: surah.surahName,
          verseNumber: surah.versesNumber.inSurah ?? 0,
        ),
        subtitle: _TimeInfo(
          createdAt: surah.createdAt,
          progress: surah.progress,
        ),
      ),
    );
  }
}

class _JuzList extends StatelessWidget {
  final LastReadJuz juz;

  const _JuzList({
    required this.juz,
  });

  @override
  Widget build(BuildContext context) {
    return _SwipeDeleteList(
      key: ValueKey(juz.createdAt),
      name: juz.name,
      onDelete: () {
        context.read<LastReadCubit>().deleteLastReadJuz(
              juz.createdAt,
            );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          JuzList.onTapJuz(
            context,
            JuzConstant(
              number: juz.number,
              name: juz.name,
              description: juz.description,
            ),
            jumpToVerse: juz.versesNumber.inQuran,
          );
        },
        title: VerseBookmarkListTile(
          juzName: juz.name,
          verseNumber: juz.versesNumber.inQuran ?? 0,
        ),
        subtitle: _TimeInfo(
          createdAt: juz.createdAt,
          progress: juz.progress,
        ),
      ),
    );
  }
}

class _SwipeDeleteList extends StatelessWidget {
  final String name;
  final Function onDelete;
  final Widget child;

  const _SwipeDeleteList({
    required this.name,
    required this.child,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(key),
      onDismissed: (direction) {
        onDelete();
      },
      background: const SizedBox(),
      secondaryBackground: Container(
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.theme.colorScheme.error.withOpacity(0.1),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete_sweep_rounded,
            color: context.theme.colorScheme.error,
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        var delete = true;
        final snackBar = context.appSnackBar(
          LocaleKeys.deleted.tr(args: [name]),
          action: SnackBarAction(
            label: LocaleKeys.undo.tr(),
            onPressed: () => delete = false,
          ),
        );
        await snackBar.closed;
        return delete;
      },
      direction: DismissDirection.endToStart,
      child: child,
    );
  }
}
