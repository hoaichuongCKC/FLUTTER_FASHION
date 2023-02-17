import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideTransitionPage<T> extends CustomTransitionPage<T> {
  SlideTransitionPage({
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
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0), // start position of the transition
                end: Offset.zero, // end position of the transition
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );
}
