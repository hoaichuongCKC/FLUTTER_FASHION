import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage<T> extends CustomTransitionPage<T> {
  FadeTransitionPage({
    required Widget child,
    Key? key,
    LocalKey? pageKey,
  }) : super(
          key: pageKey,
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.linearToEaseOut,
            );
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0.3, // start position of the transition
                end: 1.0, // end position of the transition
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );
}
