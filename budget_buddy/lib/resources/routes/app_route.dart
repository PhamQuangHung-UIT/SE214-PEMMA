import 'package:budget_buddy/presenters/profile_presenter.dart';
import 'package:budget_buddy/views/auth_view.dart';
import 'package:budget_buddy/views/create_new_password_view.dart';
import 'package:budget_buddy/views/email_verification_success_view.dart';
import 'package:budget_buddy/views/input_email_view.dart';
import 'package:budget_buddy/views/landing_view.dart';
import 'package:budget_buddy/views/login_view.dart';
import 'package:budget_buddy/views/main_navigation_view.dart';
import 'package:budget_buddy/views/requires_email_verification_view.dart';
import 'package:budget_buddy/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter routes = GoRouter(navigatorKey: navigatorKey, routes: [
        GoRoute(
            path: '/',
            redirect: (context, state) => getInitialRoute()),
        ShellRoute(
          navigatorKey: MainNavigationView.navigatorKey,
          builder: (context, state, child) 
            => MainNavigationView(child, state.fullPath!),
          routes: MainNavigationView.routeList
        ),
        GoRoute(
            path: LandingView.name, builder: (_, state) => const LandingView()),
        GoRoute(path: LoginView.name, builder: (_, state) => const LoginView()),
        GoRoute(
            path: SignUpView.name, builder: (_, state) => const SignUpView()),
        GoRoute(
            path: InputEmailView.name,
            builder: (_, state) => const InputEmailView()),
        GoRoute(
            path: CreateNewPasswordView.name,
            builder: (_, state) => CreateNewPasswordView(
                state.uri.queryParameters['email']!,
                state.uri.queryParameters['actionCode']!)),
        GoRoute(
            path: EmailVerificationSuccessView.name,
            builder: (_, state) => EmailVerificationSuccessView(
                state.uri.queryParameters['mode']!,
                state.uri.queryParameters['actionCode']!,
                state.uri.queryParameters['continueUrl']!)),
        GoRoute(
            path: AuthView.name,
            builder: (_, state) => AuthView(
                state.uri.queryParameters['mode']!,
                state.uri.queryParameters['oobCode']!,
                state.uri.queryParameters['continueUrl']!)),
        GoRoute(
            path: RequireEmailVerificationView.name,
            builder: (_, state) =>
                RequireEmailVerificationView(ProfilePresenter().user!))
      ], debugLogDiagnostics: true);

  static String? getInitialRoute() {
    var presenter = ProfilePresenter();
    if (presenter.firstRun) return LandingView.name;
    if (presenter.user == null) return LoginView.name;
    if (!presenter.user!.emailVerified) {
      return RequireEmailVerificationView.name;
    }
    return '/home';
  }
}
