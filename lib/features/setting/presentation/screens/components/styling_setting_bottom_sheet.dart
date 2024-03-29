import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/constants/font_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../../core/components/spacer.dart';
import '../../bloc/styling_setting/styling_setting_bloc.dart';

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
                  p.isLastReadReminderOn != c.isLastReadReminderOn,
              builder: (context, state) {
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(LocaleKeys.warningLastReading.tr()),
                  subtitle: Text(LocaleKeys.warningLastReadingDescription.tr()),
                  value: state.isLastReadReminderOn,
                  onChanged: (value) {
                    stylingBloc.add(
                      StylingSettingEvent.setLastReadReminder(
                        isOn: value ?? true,
                      ),
                    );
                  },
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
                  trailing: Checkbox(
                    value: state.isShowLatin,
                    onChanged: (value) {
                      stylingBloc.add(
                        StylingSettingEvent.setShowLatin(
                          isShow: value ?? true,
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
                    trailing: Checkbox(
                      value: state.isShowTranslation,
                      onChanged: (value) {
                        stylingBloc.add(
                          StylingSettingEvent.setShowTranslation(
                            isShow: value ?? true,
                          ),
                        );
                      },
                    ));
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
