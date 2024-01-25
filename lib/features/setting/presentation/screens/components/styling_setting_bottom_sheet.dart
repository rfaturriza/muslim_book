import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/core/constants/font_constants.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/core/utils/themes/color.dart';
import 'package:quranku/generated/locale_keys.g.dart';

import '../../../../../core/components/spacer.dart';
import '../../bloc/styling_setting/styling_setting_bloc.dart';

class StylingSettingBottomSheet extends StatelessWidget {
  final String title;
  final Function(double) onChangeArabicFontSize;
  final Function(double) onChangeTranslationFontSize;
  final Function(double) onChangeLatinFontSize;
  final Function(String?) onChangeArabicFontFamily;

  const StylingSettingBottomSheet({
    super.key,
    required this.title,
    required this.onChangeArabicFontSize,
    required this.onChangeTranslationFontSize,
    required this.onChangeLatinFontSize,
    required this.onChangeArabicFontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: context.textTheme.titleLarge?.copyWith(
              color: secondaryColor.shade500,
            ),
          ),
          const VSpacer(),
          Text(LocaleKeys.arabic.tr()),
          BlocBuilder<StylingSettingBloc, StylingSettingState>(
            buildWhen: (p, c) => p.arabicFontSize != c.arabicFontSize,
            builder: (context, state) {
              return Slider(
                value: state.arabicFontSize,
                min: 22,
                max: 50,
                onChanged: onChangeArabicFontSize,
              );
            },
          ),
          Text(LocaleKeys.latin.tr()),
          BlocBuilder<StylingSettingBloc, StylingSettingState>(
            buildWhen: (p, c) => p.latinFontSize != c.latinFontSize,
            builder: (context, state) {
              return Slider(
                value: state.latinFontSize,
                min: 12,
                max: 30,
                onChanged: onChangeLatinFontSize,
              );
            },
          ),
          Text(LocaleKeys.translation.tr()),
          BlocBuilder<StylingSettingBloc, StylingSettingState>(
            buildWhen: (p, c) => p.translationFontSize != c.translationFontSize,
            builder: (context, state) {
              return Slider(
                value: state.translationFontSize,
                min: 12,
                max: 30,
                onChanged: onChangeTranslationFontSize,
              );
            },
          ),
          Text(LocaleKeys.fontStyle.tr()),
          _DropdownArabicFonts(
            onChangeArabicFontFamily: onChangeArabicFontFamily,
          ),
        ],
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
          padding: const EdgeInsets.all(0),
          isExpanded: true,
          underline: const SizedBox(),
          menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
          borderRadius: BorderRadius.circular(8),
          items: FontConst.arabicFonts.map((font) {
            return DropdownMenuItem(
              value: font,
              child: ListTile(
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
