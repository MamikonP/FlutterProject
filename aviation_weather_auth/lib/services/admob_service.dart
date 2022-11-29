import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService<T> {
  T? ad;

  String get _interstitialAdID {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    return 'ca-app-pub-1640074907686374/3385331260';
  }

  String get _bannerAdID {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return 'ca-app-pub-1640074907686374/2806746769';
  }

  List<String> get _testDeviceIDs {
    return <String>[
      '62A40223-49CE-4F7A-A505-57E4EA00F1C5',
      'C7C1C2269993236B56857534271E5384',
      'FF3A692F07EB5A083AF424491A2DFA59',
      'd096564a23baac46fef55989b7b9d762',
      'cd78af074b523b02558686bf542f9dae'
    ];
  }

  Future<void> _loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: _interstitialAdID,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          this.ad = ad as T;
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  Future<void> _loadBannerAd() async {
    final BannerAd bannerAd = BannerAd(
      adUnitId: _bannerAdID,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    )..load();
    ad = bannerAd as T;
  }

  Future<void> loadAdd() async {
    await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: _testDeviceIDs));
    if (T == InterstitialAd) {
      await _loadInterstitialAd();
    } else if (T == BannerAd) {
      await _loadBannerAd();
    }
  }
}
