// ignore_for_file: constant_identifier_names

import 'package:flutter_fashion/app/presentation/setting/setting_page.dart';
import 'package:flutter_fashion/common/components/bottom_navigation_bar.dart';
import 'package:flutter_fashion/app/presentation/notification/notification_page.dart';
import 'package:flutter_fashion/app/presentation/profile/profile_page.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/routes/export.dart';
import 'package:flutter_fashion/routes/observer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class Routes {
  Routes._();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static const INTRODUCTION = _Paths.INTRODUCTION;
  static const HOME = _Paths.HOME;
  static const PROFILE = _Paths.PROFILE;
  static const LOGIN = _Paths.LOGIN;
  static const NOTIFICATION = _Paths.NOTIFICATION;

  //page second
  static const SETTING = _Paths.SETTING;
}

abstract class _Paths {
  _Paths._();
  static const INTRODUCTION = '/introduction';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const NOTIFICATION = '/notification';
  static const PROFILE = '/profile';

  //page second
  static const SETTING = '/setting';
}

class AppRoutes {
  static final router = GoRouter(
    initialLocation: Routes.LOGIN,
    navigatorKey: Routes.navigatorKey,
    debugLogDiagnostics: true,
    observers: [GoRouterObserver()],
    redirect: (context, state) {
      if (state.subloc == Routes.LOGIN) {
        String? isAuthenticated = HydratedBloc.storage.read(KeyStorage.token);

        if (isAuthenticated != null) {
          return Routes.HOME;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        parentNavigatorKey: Routes.navigatorKey,
        path: Routes.INTRODUCTION,
        builder: (context, state) => const IntroductionPage(),
      ),
      GoRoute(
        path: Routes.LOGIN,
        parentNavigatorKey: Routes.navigatorKey,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.SETTING,
        parentNavigatorKey: Routes.navigatorKey,
        builder: (context, state) => const SettingPage(),
      ),
      ShellRoute(
        navigatorKey: Routes.shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return Scaffold(
            body: child,
            /* ... */
            bottomNavigationBar: BottomNavigationBarApp(pagePath: state.subloc),
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
          )
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
    Routes.shellNavigatorKey.currentContext!.go(path);
  }

  static void pushShellKey(String path) {
    Routes.shellNavigatorKey.currentContext!.push(path);
  }
}
