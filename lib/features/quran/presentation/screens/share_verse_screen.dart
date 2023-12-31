import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/core/constants/asset_constants.dart';
import 'package:quranku/core/constants/font_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/color.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../core/components/checkbox.dart';
import '../../../../core/components/drag.dart';
import '../../../../core/utils/extension/string_ext.dart';
import '../bloc/shareVerse/share_verse_bloc.dart';

class ShareVerseScreen extends StatelessWidget {
  const ShareVerseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey canvasGlobalKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                enableDrag: true,
                useSafeArea: true,
                backgroundColor: defaultColor.shade500,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                barrierColor: Colors.transparent,
                builder: (_) => BlocProvider.value(
                  value: context.read<ShareVerseBloc>(),
                  child: const _SettingPreviewBottomSheet(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.ios_share),
              onPressed: () {
                final boundary = canvasGlobalKey.currentContext
                    ?.findRenderObject() as RenderRepaintBoundary?;
                context.read<ShareVerseBloc>().add(
                      ShareVerseEvent.onSharePressed(boundary),
                    );
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: _CanvasPreview(
          canvasGlobalKey: canvasGlobalKey,
        ),
      ),
    );
  }
}

class _CanvasPreview extends StatelessWidget {
  final GlobalKey canvasGlobalKey;

  const _CanvasPreview({required this.canvasGlobalKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareVerseBloc, ShareVerseState>(
      builder: (context, state) {
        final verse = state.verse;
        final fontSize = state.fontSize;
        return SafeArea(
          child: RepaintBoundary(
            key: canvasGlobalKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: state.backgroundColor,
                image: state.backgroundColor == null
                    ? DecorationImage(
                        image: CachedNetworkImageProvider(
                          AssetConst.imageRandomUrl,
                          cacheKey: state.randomImageUrl,
                        ),
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state.isArabicVisible) ...[
                      Text(
                        verse?.text?.arab ?? emptyString,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: fontSize * 1.5,
                          fontFamily: FontConst.lpmqIsepMisbah,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const VSpacer(),
                    ],
                    if (state.isLatinVisible) ...[
                      Text(
                        verse?.text?.transliteration?.asLocale(context) ??
                            emptyString,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: fontSize / 1.2,
                          color: primaryColor.shade100,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const VSpacer(),
                    ],
                    if (state.isTranslationVisible) ...[
                      Text(
                        verse?.translation?.asLocale(context) ?? emptyString,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const VSpacer(),
                    ],
                    if (state.juz != null) ...[
                      Text(
                        '(${LocaleKeys.juz.tr().capitalize()} '
                        '${state.juz?.number ?? emptyString} '
                        ': ${LocaleKeys.verses.tr().capitalize()} '
                        '${state.verse?.number?.inQuran ?? emptyString})',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: fontSize / 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const VSpacer(),
                    ],
                    if (state.surah != null) ...[
                      Text(
                        '(QS. '
                        '${state.surah?.name?.transliteration?.asLocale(context) ?? emptyString} '
                        ': ${LocaleKeys.verses.tr().capitalize()} '
                        '${state.verse?.number?.inSurah ?? emptyString})',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: fontSize / 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const VSpacer(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SettingPreviewBottomSheet extends StatelessWidget {
  const _SettingPreviewBottomSheet();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
        ),
        child: Wrap(
          children: [
            DragContainer(),
            _RowListColorSetting(),
            VSpacer(),
            _SettingFont(),
            VSpacer(),
            _SettingShowingText(),
          ],
        ),
      ),
    );
  }
}

class _RowListColorSetting extends StatelessWidget {
  const _RowListColorSetting();

  @override
  Widget build(BuildContext context) {
    final shareBloc = context.read<ShareVerseBloc>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<ShareVerseBloc, ShareVerseState>(
        buildWhen: (prev, cur) {
          final first = prev.randomImageUrl != cur.randomImageUrl;
          final second = prev.backgroundColor != cur.backgroundColor;
          return first || second;
        },
        builder: (context, state) {
          return Row(
            children: [
              CachedNetworkImage(
                cacheKey: state.randomImageUrl,
                imageUrl: AssetConst.imageRandomUrl,
                imageBuilder: (context, imageProvider) {
                  return GestureDetector(
                    onTap: () {
                      shareBloc.add(
                        const ShareVerseEvent.onChangeRandomImageUrl(),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 16,
                      backgroundImage: imageProvider,
                      child: state.backgroundColor == null
                          ? const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                },
                placeholder: (context, url) {
                  return CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 16,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  );
                },
              ),
              ...List.generate(
                Colors.primaries.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      shareBloc.add(
                        ShareVerseEvent.onChangeBackgroundColor(
                          Colors.primaries[index],
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.primaries[index],
                      radius: 16,
                      child: state.backgroundColor == Colors.primaries[index]
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : null,
                    ),
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

class _SettingFont extends StatelessWidget {
  const _SettingFont();

  @override
  Widget build(BuildContext context) {
    final shareBloc = context.read<ShareVerseBloc>();
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.text_format),
        ),
        Expanded(
          child: BlocBuilder<ShareVerseBloc, ShareVerseState>(
            buildWhen: (previous, current) {
              return previous.fontSize != current.fontSize;
            },
            builder: (context, state) {
              return Slider(
                value: state.fontSize,
                min: 0,
                max: 30,
                onChanged: (value) {
                  shareBloc.add(
                    ShareVerseEvent.onChangeFontSize(value),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SettingShowingText extends StatelessWidget {
  const _SettingShowingText();

  @override
  Widget build(BuildContext context) {
    final shareBloc = context.read<ShareVerseBloc>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<ShareVerseBloc, ShareVerseState>(
          buildWhen: (previous, current) {
            return previous.isArabicVisible != current.isArabicVisible;
          },
          builder: (context, state) {
            return CheckBoxListTileMuslimBook(
              title: LocaleKeys.arabic.tr(),
              value: state.isArabicVisible,
              onChanged: (value) {
                shareBloc.add(
                  ShareVerseEvent.onToggleArabicVisibility(value),
                );
              },
            );
          },
        ),
        BlocBuilder<ShareVerseBloc, ShareVerseState>(
          buildWhen: (previous, current) {
            return previous.isLatinVisible != current.isLatinVisible;
          },
          builder: (context, state) {
            return CheckBoxListTileMuslimBook(
              title: LocaleKeys.latin.tr(),
              value: state.isLatinVisible,
              onChanged: (value) {
                shareBloc.add(
                  ShareVerseEvent.onToggleLatinVisibility(value),
                );
              },
            );
          },
        ),
        BlocBuilder<ShareVerseBloc, ShareVerseState>(
          buildWhen: (previous, current) {
            return previous.isTranslationVisible !=
                current.isTranslationVisible;
          },
          builder: (context, state) {
            return CheckBoxListTileMuslimBook(
              title: LocaleKeys.translation.tr(),
              value: state.isTranslationVisible,
              onChanged: (value) {
                shareBloc.add(
                  ShareVerseEvent.onToggleTranslationVisibility(value),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
