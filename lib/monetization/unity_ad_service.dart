import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class UnityAdService {
  static const androidAppId = '4775757';
  static const placementId = "Interstitial_Android";

  Future<void> initialize() async {
    UnityAds.init(
      gameId: androidAppId,
      testMode: false,
      onComplete: () => debugPrint('Initialization Complete'),
      onFailed: (error, message) =>
          debugPrint('Initialization Failed: $error $message'),
    );
  }

  showInterstitialAd() async {
    await UnityAds.load(
        placementId: placementId,
        onComplete: (completed) {
          UnityAds.showVideoAd(placementId: placementId);
        });
  }
}
