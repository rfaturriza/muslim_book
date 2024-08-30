import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:quranku/core/constants/font_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/setting/domain/entities/last_read_reminder_mode_entity.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../../core/components/spacer.dart';
import '../../../../quran/presentation/utils/tajweed_rule.dart';
import '../../../../quran/presentation/utils/tajweed_word.dart';
import '../../bloc/styling_setting/styling_setting_bloc.dart';
import '../helper/cache_example_tajweed.dart';

class StylingSettingBottomSheet extends StatelessWidget {
  final String title;

  const StylingSettingBottomSheet({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final stylingBloc = context.read<StylingSettingBloc>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Wrap(
          children: [
            BlocBuilder<StylingSettingBloc, StylingSettingState>(
              buildWhen: (p, c) =>
                  p.lastReadReminderMode != c.lastReadReminderMode,
              builder: (context, state) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(LocaleKeys.settingLastReading.tr()),
                  subtitle: Text(LocaleKeys.settingLastReadingDescription.tr()),
                  trailing: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: ListTile.divideTiles(
                                color: context.theme.dividerColor,
                                context: context,
                                tiles: LastReadReminderModes.values.map((mode) {
                                  return ListTile(
                                    tileColor:
                                        state.lastReadReminderMode == mode
                                            ? context.theme.primaryColor
                                                .withOpacity(0.1)
                                            : null,
                                    title: Text(
                                      mode.toTitle(),
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(mode.toDescription()),
                                    onTap: () {
                                      stylingBloc.add(
                                        StylingSettingEvent.setLastReadReminder(
                                          mode: mode,
                                        ),
                                      );
                                      Navigator.pop(context);
                                    },
                                  );
                                }).toList(),
                              ).toList(),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: context.theme.primaryColor,
                        ),
                      ),
                      child: Text(
                        state.lastReadReminderMode.toTitle(),
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const VSpacer(),
            BlocBuilder<StylingSettingBloc, StylingSettingState>(
              buildWhen: (p, c) =>
                  p.isColoredTajweedEnabled != c.isColoredTajweedEnabled,
              builder: (context, state) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    children: [
                      Text(LocaleKeys.coloredTajweed.tr()),
                      const HSpacer(width: 8),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const DialogDetailTajweed();
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.theme.colorScheme.primary,
                            ),
                          ),
                          child: const Icon(
                            Icons.question_mark_rounded,
                            size: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(LocaleKeys.coloredTajweedDescription.tr()),
                  trailing:  Switch(
                    value: state.isColoredTajweedEnabled,
                    onChanged: (value) {
                      stylingBloc.add(
                        StylingSettingEvent.setColoredTajweedStatus(
                          isColoredTajweedEnabled: value,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const VSpacer(),
            BlocBuilder<StylingSettingBloc, StylingSettingState>(
              buildWhen: (p, c) => p.arabicFontSize != c.arabicFontSize,
              builder: (context, state) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(LocaleKeys.arabic.tr()),
                  subtitle: Slider(
                    value: state.arabicFontSize,
                    min: 22,
                    max: 50,
                    onChanged: (size) {
                      stylingBloc.add(
                        StylingSettingEvent.setArabicFontSize(
                          fontSize: size,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            BlocBuilder<StylingSettingBloc, StylingSettingState>(
              buildWhen: (p, c) =>
                  p.latinFontSize != c.latinFontSize ||
                  p.isShowLatin != c.isShowLatin,
              builder: (context, state) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(LocaleKeys.latin.tr()),
                  subtitle: Slider(
                    value: state.latinFontSize,
                    min: 12,
                    max: 30,
                    onChanged: (size) {
                      stylingBloc.add(
                        StylingSettingEvent.setLatinFontSize(
                          fontSize: size,
                        ),
                      );
                    },
                  ),
                  trailing: Switch(
                    value: state.isShowLatin,
                    onChanged: (value) {
                      stylingBloc.add(
                        StylingSettingEvent.setShowLatin(
                          isShow: value,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            BlocBuilder<StylingSettingBloc, StylingSettingState>(
              buildWhen: (p, c) =>
                  p.translationFontSize != c.translationFontSize ||
                  p.isShowTranslation != c.isShowTranslation,
              builder: (context, state) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(LocaleKeys.translation.tr()),
                  subtitle: Slider(
                    value: state.translationFontSize,
                    min: 12,
                    max: 30,
                    onChanged: (size) {
                      stylingBloc.add(
                        StylingSettingEvent.setTranslationFontSize(
                          fontSize: size,
                        ),
                      );
                    },
                  ),
                  trailing: Switch(
                    value: state.isShowTranslation,
                    onChanged: (value) {
                      stylingBloc.add(
                        StylingSettingEvent.setShowTranslation(
                          isShow: value,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(LocaleKeys.fontStyle.tr()),
              subtitle: _DropdownArabicFonts(
                onChangeArabicFontFamily: (fontFamily) {
                  stylingBloc.add(
                    StylingSettingEvent.setArabicFontFamily(
                      fontFamily: fontFamily ?? FontConst.lpmqIsepMisbah,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownArabicFonts extends StatelessWidget {
  final Function(String?) onChangeArabicFontFamily;

  const _DropdownArabicFonts({required this.onChangeArabicFontFamily});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StylingSettingBloc, StylingSettingState>(
      buildWhen: (p, c) => p.fontFamilyArabic != c.fontFamilyArabic,
      builder: (context, state) {
        return DropdownButton(
          icon: const Icon(Icons.font_download_outlined),
          padding: EdgeInsets.zero,
          isExpanded: true,
          underline: const SizedBox(),
          menuMaxHeight: context.height * 0.3,
          borderRadius: BorderRadius.circular(8),
          items: FontConst.arabicFonts.map((font) {
            return DropdownMenuItem(
              value: font,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
                  textAlign: TextAlign.end,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontFamily: font,
                  ),
                ),
                leading: Text(
                  font,
                  textAlign: TextAlign.end,
                  style: context.textTheme.titleSmall,
                ),
              ),
            );
          }).toList(),
          onChanged: onChangeArabicFontFamily,
          value: state.fontFamilyArabic,
        );
      },
    );
  }
}

class DialogDetailTajweed extends StatelessWidget {
  const DialogDetailTajweed({super.key});

  @override
  Widget build(BuildContext context) {
    final tajweedExampleCache = TajweedExampleCache();

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: FutureBuilder<List<TajweedWord>>(
        future: tajweedExampleCache.getExampleAyah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:  CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text(LocaleKeys.defaultErrorMessage.tr());
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      LocaleKeys.coloredTajweed.tr(),
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...ListTile.divideTiles(
                      color: context.theme.dividerColor,
                      context: context,
                      tiles: TajweedRule.values.map((rule) {
                        if (TajweedRule.getExplanation(rule).isEmpty) {
                          return const SizedBox();
                        }
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: rule.color(context)?.withAlpha(30),
                            ),
                            child: Text(
                              TajweedRule.getTitle(rule),
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: rule.color(context),
                              ),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MarkdownBody(
                                  data: TajweedRule.getExplanation(rule),
                                ),
                                const VSpacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: BlocBuilder<StylingSettingBloc,
                                      StylingSettingState>(
                                    buildWhen: (p, c) {
                                      return p.fontFamilyArabic !=
                                              c.fontFamilyArabic ||
                                          p.arabicFontSize != c.arabicFontSize;
                                    },
                                    builder: (context, state) {
                                      return Text.rich(
                                        textAlign: TextAlign.right,
                                        TextSpan(
                                          children: <TextSpan>[
                                            for (final token
                                                in snapshot.data![rule.index]
                                                    .tokens)
                                              TextSpan(
                                                text: token.text,
                                                style: context
                                                    .textTheme.headlineSmall
                                                    ?.copyWith(
                                                  height: 2.5,
                                                  fontFamily:
                                                      state.fontFamilyArabic,
                                                  fontSize:
                                                      state.arabicFontSize,
                                                  color: () {
                                                    if (token.rule.index ==
                                                        rule.index) {
                                                      return token.rule
                                                              .color(context) ??
                                                          context
                                                              .theme
                                                              .colorScheme
                                                              .onSurface;
                                                    }
                                                    return null;
                                                  }(),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
