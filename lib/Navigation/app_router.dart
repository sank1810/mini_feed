import 'package:go_router/go_router.dart';
import 'package:mini_feed/supabase/auth_refresh_stream.dart';
import 'package:mini_feed/ui/layout/scaffold_with_nav_bar.dart';
import 'package:mini_feed/ui/screens/home_screen.dart';
import 'package:mini_feed/ui/screens/profile_screen.dart';
import 'package:mini_feed/ui/screens/sign_in_screen.dart';
import 'package:mini_feed/ui/screens/sign_up_screen.dart';
import 'package:mini_feed/ui/screens/welcome_screen.dart';
import 'package:mini_feed/ui/view_models/profile_view_model.dart';
import 'package:mini_feed/ui/view_models/sign_in_view_model.dart';
import 'package:mini_feed/ui/view_models/sign_up_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  final _supabase = Supabase.instance.client;

  late final GoRouter router = GoRouter(
    initialLocation: '/welcome',
    refreshListenable: AuthRefreshStream(_supabase.auth.onAuthStateChange),
    redirect: (context, state) {
      final session = _supabase.auth.currentSession;
      final bool userConnected = session != null;
      final bool isOnWelcomePage = state.uri.path == '/welcome';
      final bool isOnSignUpScreen = state.uri.path == '/signup';
      final bool isOnSignInScreen = state.uri.path == '/signin';
      if (!userConnected &&
          !(isOnWelcomePage || isOnSignUpScreen || isOnSignInScreen)) {
        return '/welcome';
      }
      if (userConnected &&
          (isOnWelcomePage || isOnSignUpScreen || isOnSignInScreen)) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) {
          return WelcomeScreen();
        },
      ),
      GoRoute(
        name: 'sign_up_screen',
        path: '/signup',
        builder: (context, state) {
          return SignUpSreen(viewModel: SignUpViewModel());
        },
      ),
      GoRoute(
        name: 'sign_in_screen',
        path: '/signin',
        builder: (context, state) {
          return SignInScreen(viewModel: SignInViewModel());
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) =>
                    ProfileScreen(viewModel: ProfileViewModel()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
