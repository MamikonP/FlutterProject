import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../services/admob_service.dart';

class AppBannerAd extends StatefulWidget {
  const AppBannerAd({super.key});

  @override
  State<AppBannerAd> createState() => _AppBannerAdState();
}

class _AppBannerAdState extends State<AppBannerAd> {
  final AdmobService<BannerAd> _admobService = AdmobService<BannerAd>();

  @override
  void initState() {
    super.initState();
    _admobService.loadAdd().then((void value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_admobService.ad == null) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 50,
      child: AdWidget(ad: _admobService.ad!),
    );
  }
}
