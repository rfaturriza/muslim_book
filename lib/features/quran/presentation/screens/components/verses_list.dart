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
import 'package:quranku/features/quran/presentation/bloc/shareVerse/share_verse_bloc.dart';
import 'package:quranku/features/quran/presentation/screens/components/verse_popup_menu.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../core/utils/extension/string_ext.dart';
import '../../../../../core/utils/themes/color.dart';
import '../../../../../injection.dart';
import '../../../../setting/presentation/bloc/language_setting/language_setting_bloc.dart';
import '../../../../setting/presentation/bloc/styling_setting/styling_setting_bloc.dart';
import '../../../domain/entities/detail_surah.codegen.dart';
import '../../bloc/audioVerse/audio_verse_bloc.dart';
import '../../bloc/detailSurah/detail_surah_bloc.dart';
import '../share_verse_screen.dart';
import 'number_pin.dart';

enum ViewMode {
  juz,
  surah,
  setting,
}

class VersesList extends StatefulWidget {
  final ViewMode view;
  final String? preBismillah;
  final JuzConstant? juz;
  final DetailSurah? surah;
  final int? toVerses;
  final List<Verses> listVerses;

  const VersesList({
    super.key,
    required this.listVerses,
    this.preBismillah,
    required this.view,
    this.juz,
    this.surah,
    this.toVerses,
  });

  @override
  State<VersesList> createState() => _VersesListState();
}

class _VersesListState extends State<VersesList> {
  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_scrollTo);
  }

  void _scrollTo(_) async {
    if (widget.toVerses != null) {
      final toVerse = () {
        if (widget.preBismillah?.isNotEmpty == true) {
          return widget.toVerses ?? 0;
        }
        if (widget.view == ViewMode.juz) {
          return widget.toVerses ?? 0;
        }
        return (widget.toVerses ?? 0) - 1;
      }();

      _itemScrollController.scrollTo(
        index: toVerse,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _autoScrollPlayingAudio(AudioVerseState state) async {
    final index = widget.listVerses
        .map((e) => e.audio)
        .toList()
        .indexOf(state.audioVersePlaying);
    if (index != -1) {
      final indices = _itemPositionsListener.itemPositions.value
          .where((item) {
            final isTopVisible = item.itemLeadingEdge >= 0;
            final isBottomVisible = item.itemTrailingEdge <= 1.03;
            return isTopVisible && isBottomVisible;
          })
          .map((e) => e.index)
          .toList();
      final lastItem = indices.last;
      if (lastItem != widget.listVerses.length - 1) {
        _itemScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPreBismillah = widget.preBismillah?.isNotEmpty == true;
    return BlocListener<AudioVerseBloc, AudioVerseState>(
      listener: (context, state) {
        if (state.audioVersePlaying != null) {
          _autoScrollPlayingAudio(state);
        }
      },
      child: SafeArea(
        top: false,
        child: ScrollablePositionedList.separated(
          itemScrollController: _itemScrollController,
          itemPositionsListener: _itemPositionsListener,
          itemCount: () {
            if (isPreBismillah) {
              return widget.listVerses.length + 1;
            }
            return widget.listVerses.length;
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
                widget.preBismillah ?? emptyString,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontFamily: FontConst.lpmqIsepMisbah,
                ),
              );
            }
            final indexVerses = isPreBismillah ? index - 1 : index;
            final verses = widget.listVerses[indexVerses];
            return ListTileVerses(
              verses: verses,
              clickFrom: widget.view,
              juz: widget.juz,
              surah: widget.surah,
            );
          },
        ),
      ),
    );
  }
}

class ListTileVerses extends StatelessWidget {
  final ViewMode clickFrom;
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
    final audioVerseBloc = context.read<AudioVerseBloc>();
    return BlocBuilder<AudioVerseBloc, AudioVerseState>(
      buildWhen: (previous, current) {
        return previous.audioVersePlaying != current.audioVersePlaying;
      },
      builder: (context, state) {
        final isVersePlaying = state.audioVersePlaying == verses.audio;
        return Container(
          color: isVersePlaying
              ? secondaryColor.shade500.withOpacity(0.2)
              : Colors.transparent,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: FittedBox(
                        child: NumberPin(
                          number:
                              verses.number?.inSurah.toString() ?? emptyString,
                        ),
                      ),
                    ),
                    if (clickFrom != ViewMode.setting) ...[
                      Expanded(
                        child: VersePopupMenuButton(
                          isBookmarked: verses.isBookmarked,
                          onPlayPressed: () {
                            audioVerseBloc
                                .add(PlayAudioVerse(audioVerse: verses.audio));
                          },
                          onBookmarkPressed: () {
                            _onPressedBookmark(
                                context, verses, clickFrom, juz, surah);
                          },
                          onSharePressed: () {
                            context.navigateTo(
                              BlocProvider(
                                create: (context) => sl<ShareVerseBloc>()
                                  ..add(
                                    ShareVerseEvent.onInit(
                                      verse: verses,
                                      juz: juz,
                                      surah: surah,
                                    ),
                                  ),
                                child: const ShareVerseScreen(),
                              ),
                            );
                          },
                        ),
                      )
                    ]
                  ],
                ),
                title: BlocBuilder<StylingSettingBloc, StylingSettingState>(
                  buildWhen: (p, c) {
                    return p.fontFamilyArabic != c.fontFamilyArabic ||
                        p.arabicFontSize != c.arabicFontSize;
                  },
                  builder: (context, state) {
                    return Text(
                      verses.text?.arab ?? emptyString,
                      textAlign: TextAlign.right,
                      style: context.textTheme.headlineSmall?.copyWith(
                        height: 2.5,
                        fontFamily: state.fontFamilyArabic,
                        fontSize: state.arabicFontSize,
                      ),
                    );
                  },
                ),
              ),
              const VSpacer(height: 8),
              BlocBuilder<LanguageSettingBloc, LanguageSettingState>(
                buildWhen: (p, c) => p.languageLatin != c.languageLatin,
                builder: (context, languageSettingState) {
                  return ListTileTransliteration(
                    text: verses.text?.transliteration?.asLocale(
                          languageSettingState.languageLatin ?? context.locale,
                        ) ??
                        emptyString,
                    number: verses.number?.inSurah.toString() ?? emptyString,
                  );
                },
              ),
              const VSpacer(height: 8),
              BlocBuilder<LanguageSettingBloc, LanguageSettingState>(
                buildWhen: (p, c) => p.languageQuran != c.languageQuran,
                builder: (context, languageSettingState) {
                  return ListTileTranslation(
                    text: verses.translation?.asLocale(
                          languageSettingState.languageQuran ?? context.locale,
                        ) ??
                        emptyString,
                    number: verses.number?.inSurah.toString() ?? emptyString,
                  );
                },
              ),
              const VSpacer(height: 8),
            ],
          ),
        );
      },
    );
  }
}

void _onPressedBookmark(
  BuildContext context,
  Verses verses,
  ViewMode clickFrom,
  JuzConstant? juz,
  DetailSurah? surah,
) {
  if (clickFrom == ViewMode.surah) {
    final surahDetailBloc = context.read<SurahDetailBloc>();
    if (surah == null) return;
    surahDetailBloc.add(
      SurahDetailEvent.onPressedVerseBookmark(
        bookmark: VerseBookmark(
          surahName: surah.name!,
          surahNumber: surah.number!,
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
}

class ListTileTranslation extends StatelessWidget {
  final String text;
  final String number;

  const ListTileTranslation(
      {super.key, required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StylingSettingBloc, StylingSettingState>(
      builder: (context, state) {
        final textStyle = context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: state.translationFontSize,
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
      },
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
    return BlocBuilder<StylingSettingBloc, StylingSettingState>(
      builder: (context, state) {
        final textStyle = context.textTheme.bodySmall?.copyWith(
          color: primaryColor.shade400,
          fontSize: state.latinFontSize,
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
      },
    );
  }
}
