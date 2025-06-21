import 'package:go_router/go_router.dart';
import 'package:mini_feed/ui/screens/sign_in_screen.dart';
import 'package:mini_feed/ui/screens/sign_up_screen.dart';
import 'package:mini_feed/ui/screens/welcome_screen.dart';
import 'package:mini_feed/ui/view_models/sign_up_view_model.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/welcome',
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
          return SignInScreen();
        },
      ),
    ],
  );
}
