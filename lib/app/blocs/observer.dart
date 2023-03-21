import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("on create: $bloc", name: "Observer create");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("on change: $bloc", name: "Observer change");
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log("on Error: ${bloc.state} $error ", name: "Observer error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("on Transition: $transition  ", name: "Observer transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("on close: $bloc  ", name: "Observer close");
    super.onClose(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log("on event: $bloc  ", name: "Observer Event");
    super.onEvent(bloc, event);
  }
}
