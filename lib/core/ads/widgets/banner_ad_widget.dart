import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../ad_placement.dart';
import '../ad_placement_policy.dart';
import '../ad_unit_ids.dart';
import '../../utils/app_logger.dart';

class BannerAdWidget extends StatefulWidget {
  final AdPlacement placement;
  final AdSize size;

  const BannerAdWidget({
    super.key,
    required this.placement,
    this.size = AdSize.banner,
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    if (!AdPlacementPolicy.shouldShowBanner(widget.placement)) {
      return;
    }

    _bannerAd = BannerAd(
      adUnitId: AdUnitIds.bannerAdUnitId,
      request: const AdRequest(),
      size: widget.size,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          AppLogger.error('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!AdPlacementPolicy.shouldShowBanner(widget.placement)) {
      return const SizedBox.shrink();
    }

    if (_isLoaded && _bannerAd != null) {
      return SafeArea(
        child: SizedBox(
          width: widget.size.width.toDouble(),
          height: widget.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
