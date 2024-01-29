import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/core/constants/asset_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/color.dart';
import 'package:quranku/features/setting/presentation/bloc/styling_setting/styling_setting_bloc.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../core/components/checkbox.dart';
import '../../../../core/utils/extension/string_ext.dart';
import '../../../setting/presentation/bloc/language_setting/language_setting_bloc.dart';
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (state.isArabicVisible) ...[
                          BlocBuilder<StylingSettingBloc, StylingSettingState>(
                            buildWhen: (p, c) =>
                                p.fontFamilyArabic != c.fontFamilyArabic,
                            builder: (context, stylingState) {
                              return Text(
                                verse?.text?.arab ?? emptyString,
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontSize: fontSize * 1.5,
                                  fontFamily: stylingState.fontFamilyArabic,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                          const VSpacer(),
                        ],
                        if (state.isLatinVisible) ...[
                          BlocBuilder<LanguageSettingBloc,
                              LanguageSettingState>(
                            buildWhen: (p, c) =>
                                p.languageLatin != c.languageLatin,
                            builder: (context, languageSettingState) {
                              return Text(
                                verse?.text?.transliteration?.asLocale(
                                      languageSettingState.languageLatin ??
                                          context.locale,
                                    ) ??
                                    emptyString,
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: fontSize / 1.2,
                                  color: primaryColor.shade100,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                          const VSpacer(),
                        ],
                        if (state.isTranslationVisible) ...[
                          BlocBuilder<LanguageSettingBloc,
                              LanguageSettingState>(
                            buildWhen: (p, c) =>
                                p.languageQuran != c.languageQuran,
                            builder: (context, languageSettingState) {
                              return Text(
                                verse?.translation?.asLocale(
                                      languageSettingState.languageQuran ??
                                          context.locale,
                                    ) ??
                                    emptyString,
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
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
                          BlocBuilder<LanguageSettingBloc,
                              LanguageSettingState>(
                            buildWhen: (p, c) =>
                                p.languageLatin != c.languageLatin,
                            builder: (context, languageSettingState) {
                              return Text(
                                '(QS. '
                                '${state.surah?.name?.transliteration?.asLocale(
                                      languageSettingState.languageLatin ??
                                          context.locale,
                                    ) ?? emptyString} '
                                ': ${LocaleKeys.verses.tr().capitalize()} '
                                '${state.verse?.number?.inSurah ?? emptyString})',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: fontSize / 1.2,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                          const VSpacer(),
                        ],
                      ],
                    ),
                    const _CopyRightMuslimBook(),
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

class _CopyRightMuslimBook extends StatelessWidget {
  const _CopyRightMuslimBook();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipOval(
            child: SvgPicture.asset(
              AssetConst.logoAPP,
              width: 18,
              height: 18,
            ),
          ),
          const HSpacer(width: 4),
          Text(
            LocaleKeys.appName.tr(),
            style: context.textTheme.titleSmall?.copyWith(
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
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
                errorWidget: (context, url, error) {
                  return GestureDetector(
                    onTap: () {
                      shareBloc.add(
                        const ShareVerseEvent.onChangeRandomImageUrl(),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 16,
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
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
