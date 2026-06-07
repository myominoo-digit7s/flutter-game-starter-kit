import 'package:go_router/go_router.dart';

import '../../features/home/home_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/shop/shop_screen.dart';
import '../../features/leaderboard/leaderboard_screen.dart';
import '../../features/game_shell/game_shell_screen.dart';
import '../../features/compliance/compliance_home_screen.dart';
import '../../features/compliance/privacy_policy_screen.dart';
import '../../features/compliance/terms_of_service_screen.dart';
import '../../features/compliance/data_safety_screen.dart';
import '../../features/compliance/content_rating_screen.dart';
import '../../features/compliance/ads_disclosure_screen.dart';
import '../../features/compliance/children_family_policy_screen.dart';
import '../../features/compliance/store_readiness_screen.dart';
import 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.game,
      builder: (context, state) => const GameShellScreen(),
    ),
    GoRoute(
      path: AppRoutes.compliance,
      name: AppRoutes.compliance,
      builder: (context, state) => const ComplianceHomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.privacyPolicy,
      name: AppRoutes.privacyPolicy,
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: AppRoutes.termsOfService,
      name: AppRoutes.termsOfService,
      builder: (context, state) => const TermsOfServiceScreen(),
    ),
    GoRoute(
      path: AppRoutes.dataSafety,
      name: AppRoutes.dataSafety,
      builder: (context, state) => const DataSafetyScreen(),
    ),
    GoRoute(
      path: AppRoutes.contentRating,
      name: AppRoutes.contentRating,
      builder: (context, state) => const ContentRatingScreen(),
    ),
    GoRoute(
      path: AppRoutes.adsDisclosure,
      name: AppRoutes.adsDisclosure,
      builder: (context, state) => const AdsDisclosureScreen(),
    ),
    GoRoute(
      path: AppRoutes.childrenFamilyPolicy,
      name: AppRoutes.childrenFamilyPolicy,
      builder: (context, state) => const ChildrenFamilyPolicyScreen(),
    ),
    GoRoute(
      path: AppRoutes.storeReadiness,
      name: AppRoutes.storeReadiness,
      builder: (context, state) => const StoreReadinessScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.shop,
      builder: (context, state) => const ShopScreen(),
    ),
    GoRoute(
      path: AppRoutes.leaderboard,
      builder: (context, state) => const LeaderboardScreen(),
    ),
  ],
);
