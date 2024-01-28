import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobConst {
  static const List<String> testDevice = [
    '016dc064-ed13-410f-817c-15cde9a02c61',
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
