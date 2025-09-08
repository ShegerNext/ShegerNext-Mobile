import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shegernext/core/config/route_names.dart';
import 'package:shegernext/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:shegernext/features/onboarding/presentation/screens/placeholder_home_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.onboarding,
  routes: <RouteBase>[
    GoRoute(
      path: RouteNames.onboarding,
      name: RouteNames.onboarding,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: OnboardingPage()),
    ),
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: PlaceholderHomePage()),
    ),
  ],
);
