import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import 'analytics_service.dart';
import '../utils/app_logger.dart';

class AnalyticsObserver extends WidgetsBindingObserver {
  final AnalyticsService _analytics;
  String? _currentSessionId;
  DateTime? _sessionStartTime;

  AnalyticsObserver(this._analytics) {
    WidgetsBinding.instance.addObserver(this);
    _startSession();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _endSession();
  }

  void _startSession() {
    _currentSessionId = const Uuid().v4();
    _sessionStartTime = DateTime.now();
    _analytics.logSessionStart(sessionId: _currentSessionId!);
    AppLogger.log('AnalyticsObserver: Session Started [$_currentSessionId]');
  }

  void _endSession() {
    if (_currentSessionId != null && _sessionStartTime != null) {
      final duration = DateTime.now().difference(_sessionStartTime!);
      _analytics.logSessionEnd(
        sessionId: _currentSessionId!,
        duration: duration,
      );
      AppLogger.log('AnalyticsObserver: Session Ended [$_currentSessionId]');
      _currentSessionId = null;
      _sessionStartTime = null;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_currentSessionId == null) {
        _startSession();
      }
    } else if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _endSession();
    }
  }
}
