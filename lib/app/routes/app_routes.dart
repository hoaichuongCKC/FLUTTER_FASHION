// ignore_for_file: constant_identifier_names

import 'package:flutter_fashion/app/common/components/bottom_navigation_bar.dart';
import 'package:flutter_fashion/app/presentation/notification/notification_page.dart';
import 'package:flutter_fashion/app/presentation/profile/profile_page.dart';
import 'package:flutter_fashion/app/routes/export.dart';
import 'package:flutter_fashion/app/routes/observer.dart';

abstract class Routes {
  Routes._();
  static const INTRODUCTION = _Paths.INTRODUCTION;
  static const HOME = _Paths.HOME;
  static const PROFILE = _Paths.PROFILE;
  static const LOGIN = _Paths.LOGIN;
  static const NOTIFICATION = _Paths.NOTIFICATION;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();
}

abstract class _Paths {
  _Paths._();
  static const INTRODUCTION = '/introduction';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const PROFILE = '/profile';
  static const NOTIFICATION = '/notification';
}

class AppRoutes {
  static final router = GoRouter(
    initialLocation: Routes.INTRODUCTION,
    navigatorKey: Routes.navigatorKey,
    debugLogDiagnostics: true,
    observers: [GoRouterObserver()],
    routes: [
      GoRoute(
        path: Routes.INTRODUCTION,
        builder: (context, state) => const IntroductionPage(),
      ),
      GoRoute(
        path: Routes.LOGIN,
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        navigatorKey: Routes.shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return Scaffold(
            body: child,
            /* ... */
            bottomNavigationBar: const BottomNavigationBarApp(),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            parentNavigatorKey: Routes.shellNavigatorKey,
            path: Routes.HOME,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: HomePage(),
              );
            },
          ),
          GoRoute(
            path: Routes.NOTIFICATION,
            parentNavigatorKey: Routes.shellNavigatorKey,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: NotificationPage(),
              );
            },
          ),
          GoRoute(
            path: Routes.PROFILE,
            parentNavigatorKey: Routes.shellNavigatorKey,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: ProfilePage(),
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );

  static void go(String path) => Routes.navigatorKey.currentContext!.go(path);

  static void pop() => Routes.navigatorKey.currentContext!.pop();

  static void push(String path) =>
      Routes.navigatorKey.currentContext!.push(path);

  static void goShellKey(String path) {
    Routes.navigatorKey.currentContext!.go(path);
  }
}
