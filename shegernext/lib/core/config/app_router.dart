import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shegernext/core/config/route_names.dart';
import 'package:shegernext/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:shegernext/features/onboarding/presentation/screens/placeholder_home_page.dart';
import 'package:shegernext/features/complaints/presentation/screens/submit_complaint_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shegernext/injection_container.dart';
import 'package:shegernext/features/complaints/presentation/bloc/complaints_bloc.dart';
import 'package:shegernext/features/auth/presentation/screens/login_page.dart';
import 'package:shegernext/features/auth/presentation/screens/signup_page.dart';
import 'package:shegernext/features/categories/presentation/screens/category_select_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.categorySelect,
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
    GoRoute(
      path: RouteNames.login,
      name: RouteNames.login,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: LoginPage()),
    ),
    GoRoute(
      path: RouteNames.signup,
      name: RouteNames.signup,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: SignupPage()),
    ),
    GoRoute(
      path: RouteNames.categorySelect,
      name: RouteNames.categorySelect,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: CategorySelectPage()),
    ),
    GoRoute(
      path: RouteNames.submitComplaint,
      name: RouteNames.submitComplaint,
      pageBuilder: (BuildContext context, GoRouterState state) {
        final String? category = state.extra as String?;
        return MaterialPage(
          child: BlocProvider(
            create: (_) => sl<ComplaintsBloc>(),
            child: SubmitComplaintPage(initialCategory: category),
          ),
        );
      },
    ),
  ],
);
