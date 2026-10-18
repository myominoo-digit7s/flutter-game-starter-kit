import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config/environment_config.dart';
import '../ad_placement.dart';
import '../ad_placement_policy.dart';
import '../ad_unit_ids.dart';
import '../../utils/app_logger.dart';

typedef BannerAdFactory =
    BannerAd Function({
      required String adUnitId,
      required AdRequest request,
      required AdSize size,
      required BannerAdListener listener,
    });

class BannerAdWidget extends StatefulWidget {
  final AdPlacement placement;
  final AdSize size;
  final bool enabled;
  final String? Function()? adUnitIdResolver;
  final BannerAdFactory? createBannerAd;

  const BannerAdWidget({
    super.key,
    required this.placement,
    this.size = AdSize.banner,
    this.enabled = EnvironmentConfig.adsEnabled,
    this.adUnitIdResolver,
    this.createBannerAd,
  });

  static BannerAd _createMobileBannerAd({
    required String adUnitId,
    required AdRequest request,
    required AdSize size,
    required BannerAdListener listener,
  }) => BannerAd(
    adUnitId: adUnitId,
    request: request,
    size: size,
    listener: listener,
  );

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  VoidCallback? _disposeBannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    if (!widget.enabled) return;
    if (!AdPlacementPolicy.shouldShowBanner(widget.placement)) {
      return;
    }

    if (!AdUnitIds.hasRequiredIdsForCurrentBuild) {
      AppLogger.error(
        'Banner ad request skipped because release ad unit IDs are '
        'incomplete.',
      );
      return;
    }

    final adUnitId =
        (widget.adUnitIdResolver ?? (() => AdUnitIds.bannerAdUnitId))();
    if (adUnitId == null) {
      AppLogger.error(
        'Banner ad request skipped because this platform has no '
        'configured ad unit ID.',
      );
      return;
    }

    late final BannerAd bannerAd;
    var disposed = false;
    void disposeOnce() {
      if (disposed) return;
      disposed = true;
      bannerAd.dispose();
    }

    bannerAd = (widget.createBannerAd ?? BannerAdWidget._createMobileBannerAd)(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: widget.size,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (disposed || !mounted || !identical(_bannerAd, ad)) {
            disposeOnce();
            return;
          }
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          AppLogger.error('BannerAd failed to load: $error');
          if (identical(_bannerAd, ad)) {
            _bannerAd = null;
            _isLoaded = false;
          }
          disposeOnce();
        },
      ),
    );
    _bannerAd = bannerAd;
    _disposeBannerAd = disposeOnce;
    bannerAd.load().catchError((Object error, StackTrace stackTrace) {
      if (disposed) return;
      AppLogger.error(
        'BannerAd load request failed: $error',
        error,
        stackTrace,
      );
      if (identical(_bannerAd, bannerAd)) {
        _bannerAd = null;
        _isLoaded = false;
      }
      disposeOnce();
    });
  }

  @override
  void dispose() {
    _disposeBannerAd?.call();
    _disposeBannerAd = null;
    _bannerAd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return const SizedBox.shrink();
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
