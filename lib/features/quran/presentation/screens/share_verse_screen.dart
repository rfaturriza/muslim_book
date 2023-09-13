import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/core/constants/font_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/color.dart';
import 'package:quranku/generated/locale_keys.g.dart';

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
    const imageRandomUrl =
        'https://source.unsplash.com/random/1080x1920?nature';
    return BlocBuilder<ShareVerseBloc, ShareVerseState>(
      builder: (context, state) {
        final verse = state.verse;
        final fontSize = state.fontSize;
        return SafeArea(
          child: Stack(
            children: [
              RepaintBoundary(
                key: canvasGlobalKey,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: state.backgroundColor,
                    image: state.backgroundColor == null
                        ? DecorationImage(
                            image: const CachedNetworkImageProvider(
                              imageRandomUrl,
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
                            verse?.translation?.asLocale(context) ??
                                emptyString,
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
                            '(${LocaleKeys.juz.capitalize()} '
                            '${state.juz?.number ?? emptyString} '
                            ': ${LocaleKeys.verses.capitalize()} '
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
                            ': ${LocaleKeys.verses.capitalize()} '
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
              Positioned(
                top: 10,
                right: 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      enableDrag: true,
                      useSafeArea: true,
                      backgroundColor: context.theme.colorScheme.background,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      barrierColor: Colors.transparent,
                      showDragHandle: true,
                      builder: (_) => BlocProvider.value(
                        value: context.read<ShareVerseBloc>(),
                        child: const _SettingPreviewBottomSheet(),
                      ),
                    );
                  },
                  child: Text(
                    'Edit',
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
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
    final shareBloc = context.read<ShareVerseBloc>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VSpacer(),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.abc),
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
                        max: 100,
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
            ),
            const VSpacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<ShareVerseBloc, ShareVerseState>(
                  buildWhen: (previous, current) {
                    return previous.isArabicVisible != current.isArabicVisible;
                  },
                  builder: (context, state) {
                    return CheckBoxBottomSheet(
                      title: 'Arabic',
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
                    return CheckBoxBottomSheet(
                      title: 'Latin',
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
                    return CheckBoxBottomSheet(
                      title: 'Translation',
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
            ),
          ],
        ),
      ),
    );
  }
}

class CheckBoxBottomSheet extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CheckBoxBottomSheet({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: defaultColor.shade50,
          activeColor: context.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(
            color: defaultColor.shade50,
            width: 2,
          ),
        ),
        Text(title),
      ],
    );
  }
}
