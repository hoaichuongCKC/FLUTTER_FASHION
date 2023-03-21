import 'package:flutter/material.dart';
import 'dart:developer';

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        log("background mode", name: "APP-LIFE-CYLCE");
        break;
      case AppLifecycleState.resumed:
        log("foreground mode", name: "APP-LIFE-CYLCE");
        break;
      case AppLifecycleState.inactive:
        log("inactive mode", name: "APP-LIFE-CYLCE");
        break;
      case AppLifecycleState.detached:
        log("detached mode", name: "APP-LIFE-CYLCE");
        break;
      default:
    }
  }
}

class Phoenix extends StatefulWidget {
  final Widget child;

  const Phoenix({Key? key, required this.child}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PhoenixState createState() => _PhoenixState();

  static rebirth(BuildContext context) {
    context.findAncestorStateOfType<_PhoenixState>()!.restartApp();
  }
}

class _PhoenixState extends State<Phoenix> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}
