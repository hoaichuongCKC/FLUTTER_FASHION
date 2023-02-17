// ignore_for_file: depend_on_referenced_packages

// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void darkTheme() => emit(ThemeState.dark());

  void lightTheme() => emit(ThemeState.light());

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState(isLight: json["isLight"]);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {"isLight": state.isLight};
  }
}
