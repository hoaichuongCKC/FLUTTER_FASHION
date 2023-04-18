import 'dart:developer';
import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPush: $route', name: "Go routes push");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPush: $route', name: "Go routes pop");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPush: $route', name: "Go routes remove");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('MyTest didPush: $newRoute', name: "Go routes didReplace");
  }
}
