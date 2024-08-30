import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/quran/presentation/screens/components/app_bar_detail_screen.dart';
import 'package:quranku/features/setting/presentation/screens/components/language_choose_bottom_sheet.dart';
import 'package:quranku/features/setting/presentation/screens/helper/translate_helper.dart';

import '../../../../core/constants/admob_constants.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/language_setting/language_setting_bloc.dart';

class LanguageSettingScreen extends StatelessWidget {
  const LanguageSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void showAdsOnAppLanguage() {
      context.showLoadingDialog();
      AdMobConst.showRewardedAd(
        adUnitId: AdMobConst.rewardedSettingID,
        onEarnedReward: (rewardItem) {
          showModalBottomSheet(
            context: context,
            enableDrag: true,
            builder: (_) => LanguageChooseBottomSheet(
              title: LocaleKeys.applicationLanguage.tr(),
              languages: context.supportTranslateApplication,
              onTap: (Locale locale) {
                context.setLocale(locale);
                Navigator.pop(context);
              },
            ),
          );
        },
        onLoaded: () {
          context.navigateBack();
        },
        onFailedToLoad: (String message) {
          context.navigateBack();
          context.showErrorToast(message);
        },
      );
    }

    void showAdsOnTranslation() {
      context.showLoadingDialog();
      AdMobConst.showRewardedAd(
        adUnitId: AdMobConst.rewardedSettingID,
        onEarnedReward: (rewardItem) {
          showModalBottomSheet(
            context: context,
            enableDrag: true,
            builder: (_) => LanguageChooseBottomSheet(
              title: LocaleKeys.quranTranslation.tr(),
              languages: context.supportTranslateQuran,
              onTap: (Locale locale) {
                context.read<LanguageSettingBloc>().add(
                      LanguageSettingEvent.setQuranLanguage(
                        locale: locale,
                      ),
                    );
                Navigator.pop(context);
              },
            ),
          );
        },
        onLoaded: () {
          context.navigateBack();
        },
        onFailedToLoad: (String message) {
          context.navigateBack();
          context.showErrorToast(message);
        },
      );
    }

    void showAdsOnLatin() {
      context.showLoadingDialog();
      AdMobConst.showRewardedAd(
        adUnitId: AdMobConst.rewardedSettingID,
        onEarnedReward: (rewardItem) {
          showModalBottomSheet(
            context: context,
            enableDrag: true,
            builder: (_) => BlocProvider.value(
              value: context.read<LanguageSettingBloc>(),
              child: LanguageChooseBottomSheet(
                title: LocaleKeys.latinTranslation.tr(),
                languages: context.supportTranslateLatin,
                onTap: (Locale locale) {
                  context.read<LanguageSettingBloc>().add(
                        LanguageSettingEvent.setLatinLanguage(
                          locale: locale,
                        ),
                      );
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        onLoaded: () {
          context.navigateBack();
        },
        onFailedToLoad: (String message) {
          context.navigateBack();
          context.showErrorToast(message);
        },
      );
    }

    void showAdsOnPrayerTime() {
      context.showLoadingDialog();
      AdMobConst.showRewardedAd(
        adUnitId: AdMobConst.rewardedSettingID,
        onEarnedReward: (rewardItem) {
          showModalBottomSheet(
            context: context,
            enableDrag: true,
            builder: (_) => BlocProvider.value(
              value: context.read<LanguageSettingBloc>(),
              child: LanguageChooseBottomSheet(
                title: LocaleKeys.prayTimeLanguage.tr(),
                languages: context.supportTranslatePrayerTime,
                onTap: (Locale locale) {
                  context.read<LanguageSettingBloc>().add(
                        LanguageSettingEvent.setPrayerLanguage(
                          locale: locale,
                        ),
                      );
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        onLoaded: () {
          context.navigateBack();
        },
        onFailedToLoad: (String message) {
          context.navigateBack();
          context.showErrorToast(message);
        },
      );
    }

    return BlocConsumer<LanguageSettingBloc, LanguageSettingState>(
      listener: (context, state) {
        if (state.statusLatin == FormzSubmissionStatus.failure) {
          context.showErrorToast("Failed to set latin language");
        }
        if (state.statusPrayerTime == FormzSubmissionStatus.failure) {
          context.showErrorToast("Failed to set prayer language");
        }
        if (state.statusQuran == FormzSubmissionStatus.failure) {
          context.showErrorToast("Failed to set quran language");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarDetailScreen(title: LocaleKeys.language.tr()),
          body: Builder(builder: (context) {
            return ListView(
              children: [
                ListTile(
                  title: Text(LocaleKeys.applicationLanguage.tr()),
                  subtitle: Text(
                    context.defaultLanguageFor(context.locale),
                  ),
                  onTap: showAdsOnAppLanguage,
                ),
                const Divider(),
                ListTile(
                  title: Text(LocaleKeys.quranTranslation.tr()),
                  subtitle: Text(
                    context.defaultLanguageFor(state.languageQuran),
                  ),
                  onTap: showAdsOnTranslation,
                ),
                const Divider(),
                ListTile(
                  title: Text(LocaleKeys.latinTranslation.tr()),
                  subtitle: Text(
                    context.defaultLanguageFor(state.languageLatin),
                  ),
                  onTap: showAdsOnLatin,
                ),
                const Divider(),
                ListTile(
                  title: Text(LocaleKeys.prayTimeLanguage.tr()),
                  subtitle: Text(
                    context.defaultLanguageFor(state.languagePrayerTime),
                  ),
                  onTap: showAdsOnPrayerTime,
                ),
                const Divider(),
              ],
            );
          }),
        );
      },
    );
  }
}
