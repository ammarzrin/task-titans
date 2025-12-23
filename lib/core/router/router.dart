import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/data/repositories/auth_repository.dart';
import 'package:tasktitans/features/auth/presentation/login_screen.dart';

import 'package:tasktitans/features/auth/presentation/profile_selection_screen.dart';

import 'package:tasktitans/features/auth/presentation/parent_profiles_screen.dart';
import 'package:tasktitans/features/dashboard/presentation/parent_dashboard_shell.dart';
import 'package:tasktitans/features/missions/presentation/parent_missions_screen.dart';
import 'package:tasktitans/features/shop/presentation/parent_rewards_screen.dart';

import 'package:tasktitans/features/auth/presentation/onboarding/admin_profile_setup_screen.dart';
import 'package:tasktitans/features/auth/presentation/onboarding/family_setup_screen.dart';
import 'package:tasktitans/features/auth/presentation/signup_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: StreamListenable(authRepository.authStateChanges),
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;

      final isLoginRoute = path == '/login';
      final isSignupRoute = path == '/signup';
      final isOnboardingRoute = path.startsWith('/onboarding');

      if (!isLoggedIn && !isLoginRoute && !isSignupRoute) {
        return '/login';
      }

      if (isLoggedIn && (isLoginRoute || isSignupRoute)) {
        // Redirect to Profile Selection when logged in
        return '/profile-selection';
      }

      // Note: We don't block access to onboarding here,
      // ProfileSelectionScreen handles the redirection to it if needed.

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/onboarding/profile',
        builder: (context, state) => const AdminProfileSetupScreen(),
      ),
      GoRoute(
        path: '/onboarding/family',
        builder: (context, state) => const FamilySetupScreen(),
      ),
      GoRoute(
        path: '/profile-selection',
        builder: (context, state) => const ProfileSelectionScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ParentDashboardShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/parent/dashboard', // Default route
                builder: (context, state) => const ParentMissionsScreen(),
              ),
              GoRoute(
                path: '/parent/missions',
                builder: (context, state) => const ParentMissionsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/parent/rewards',
                builder: (context, state) => const ParentRewardsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/parent/profiles',
                builder: (context, state) => const ParentProfilesScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/child/dashboard',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Child Dashboard (Hero HQ)')),
        ),
      ),
    ],
  );
});

// Helper to convert Stream to Listenable for GoRouter
class StreamListenable extends ChangeNotifier {
  final Stream stream;
  StreamListenable(this.stream) {
    stream.listen((_) => notifyListeners());
  }
}
