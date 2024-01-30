import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quranku/core/components/divider.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/features/quran/presentation/screens/components/app_bar_detail_screen.dart';
import 'package:quranku/features/setting/presentation/screens/components/language_choose_bottom_sheet.dart';
import 'package:quranku/features/setting/presentation/screens/helper/translate_helper.dart';

import '../../../../core/constants/admob_constants.dart';
import '../../../../generated/locale_keys.g.dart';
import '../bloc/language_setting/language_setting_bloc.dart';

class LanguageSettingScreen extends StatefulWidget {
  const LanguageSettingScreen({super.key});

  @override
  State<LanguageSettingScreen> createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    AdMobConst.createRewardedAd(
      adUnitId: AdMobConst.rewardedSettingID,
      onLoaded: (ad) {
        setState(() {
          _rewardedAd = ad;
        });
      },
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  void showAdsOnAppLanguage() {
    _rewardedAd?.showRewardedAd(
      adUnitId: AdMobConst.rewardedSettingID,
      onUserEarnedReward: (ad, rewardItem) {
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
      onReloadAd: (RewardedAd ad) {
        setState(() {
          _rewardedAd = ad;
        });
      },
    );
  }

  void showAdsOnTranslation() {
    _rewardedAd?.showRewardedAd(
      adUnitId: AdMobConst.rewardedSettingID,
      onUserEarnedReward: (ad, rewardItem) {
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
      onReloadAd: (RewardedAd ad) {
        setState(() {
          _rewardedAd = ad;
        });
      },
    );
  }

  void showAdsOnLatin() {
    _rewardedAd?.showRewardedAd(
      adUnitId: AdMobConst.rewardedSettingID,
      onUserEarnedReward: (ad, rewardItem) {
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
      onReloadAd: (RewardedAd ad) {
        setState(() {
          _rewardedAd = ad;
        });
      },
    );
  }

  void showAdsOnPrayerTime() {
    _rewardedAd?.showRewardedAd(
      adUnitId: AdMobConst.rewardedSettingID,
      onUserEarnedReward: (ad, rewardItem) {
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
      onReloadAd: (RewardedAd ad) {
        setState(() {
          _rewardedAd = ad;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            if (_rewardedAd == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: [
                ListTile(
                  title: Text(LocaleKeys.applicationLanguage.tr()),
                  subtitle: Text(
                    context.defaultLanguageFor(context.locale),
                  ),
                  onTap: showAdsOnAppLanguage,
                ),
                const DividerMuslimBook(),
                ListTile(
                  title: Text(LocaleKeys.quranTranslation.tr()),
                  subtitle: Text(
                    context.defaultLanguageFor(state.languageQuran),
                  ),
                  onTap: showAdsOnTranslation,
                ),
                const DividerMuslimBook(),
                ListTile(
                  title: Text(LocaleKeys.latinTranslation.tr()),
                  subtitle: Text(
                    context.defaultLanguageFor(state.languageLatin),
                  ),
                  onTap: showAdsOnLatin,
                ),
                const DividerMuslimBook(),
                ListTile(
                  title: Text(LocaleKeys.prayTimeLanguage.tr()),
                  subtitle: Text(
                    context.defaultLanguageFor(state.languagePrayerTime),
                  ),
                  onTap: showAdsOnPrayerTime,
                ),
                const DividerMuslimBook(),
              ],
            );
          }),
        );
      },
    );
  }
}
