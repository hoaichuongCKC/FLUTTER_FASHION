import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      print("on Create: $bloc");
    }
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      print("on Change: $bloc");
    }
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print("on Error: $bloc ${error.toString()}");
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) {
      print("on Transition: $bloc");
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) {
      print("on Close: $bloc");
      super.onClose(bloc);
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (kDebugMode) {
      print("on Event: $bloc");
    }
    super.onEvent(bloc, event);
  }
}
