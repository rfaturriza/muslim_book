import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobConst {
  static const List<String> testDevice = [
    '44E72C0E3C5644F9CB7D8ADE66AE51E4',
    '41994ef2-bd34-45a8-95f5-10ca1ad1abe1',
  ];
  static const int maxFailedLoadAttempts = 3;
  static String rewardedSettingID = () {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2622910246074431/2728290404';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return '';
    }
  }();
  static String rewardedInterstitialSettingID = () {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2622910246074431/6674988866';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return '';
    }
  }();
  static String bannerGeneralID = () {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2622910246074431/2069998630';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return '';
    }
  }();
  static String bannerShareID = () {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2622910246074431/2852121905';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return '';
    }
  }();
  static String rewardedInterstitialShareID = () {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2622910246074431/5976160452';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return '';
    }
  }();
  static String rewardedInterstitialLastReadHistory = () {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2622910246074431/5837419450';
    } else if (Platform.isIOS) {
      return '';
    } else {
      return '';
    }
  }();

  static const AdRequest request = AdRequest(
    nonPersonalizedAds: true,
  );

  static void createRewardedAd({
    required String adUnitId,
    required void Function(RewardedAd ad) onLoaded,
  }) {
    var numRewardedLoadAttempts = 0;
    RewardedAd.load(
      adUnitId: adUnitId,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          onLoaded(ad);
          numRewardedLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          numRewardedLoadAttempts++;
          if (numRewardedLoadAttempts < maxFailedLoadAttempts) {
            createRewardedAd(
              adUnitId: adUnitId,
              onLoaded: onLoaded,
            );
          }
        },
      ),
    );
  }

  static Future<void> showRewardedInterstitialAd({
    required String adUnitId,
    required void Function(RewardItem rewardItem) onEarnedReward,
    required void Function() onLoaded,
    required void Function(String message) onFailedToLoad,
  }) async {
    if (kDebugMode || kProfileMode || kReleaseMode) {
      onLoaded();
      onEarnedReward(RewardItem(1, 'Ads'));
      return;
    }
    await RewardedInterstitialAd.load(
      adUnitId: adUnitId,
      request: request,
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          onLoaded();
          ad.show(onUserEarnedReward: (_, rewardItem) {
            onEarnedReward(rewardItem);
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          onLoaded();
          onEarnedReward(RewardItem(1, 'Ads'));
        },
      ),
    );
  }

  static Future<void> showRewardedAd({
    required String adUnitId,
    required void Function(RewardItem rewardItem) onEarnedReward,
    required void Function() onLoaded,
    required void Function(String message) onFailedToLoad,
  }) async {
    if (kDebugMode || kProfileMode || kReleaseMode) {
      onLoaded();
      onEarnedReward(RewardItem(1, 'Ads'));
      return;
    }
    await RewardedAd.load(
      adUnitId: adUnitId,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          onLoaded();
          ad.show(onUserEarnedReward: (_, rewardItem) {
            onEarnedReward(rewardItem);
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          onLoaded();
          onEarnedReward(RewardItem(1, 'Ads'));
        },
      ),
    );
  }
}

extension AdMobConstExt on RewardedAd? {
  void showRewardedAd({
    required String adUnitId,
    required void Function(AdWithoutView ad, RewardItem rewardItem)
        onUserEarnedReward,
    required void Function(RewardedAd ad) onReloadAd,
  }) {
    if (this == null) {
      return;
    }
    this?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        AdMobConst.createRewardedAd(
          adUnitId: adUnitId,
          onLoaded: onReloadAd,
        );
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        AdMobConst.createRewardedAd(
          adUnitId: adUnitId,
          onLoaded: onReloadAd,
        );
      },
    );
    this?.setImmersiveMode(true);
    this?.show(
      onUserEarnedReward: onUserEarnedReward,
    );
  }
}
