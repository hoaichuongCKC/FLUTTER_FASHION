// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'language_state.dart';

class LanguageCubit extends HydratedCubit<LanguageState> {
  LanguageCubit() : super(LanguageState.initial());

  void changedVietnamese() => emit(LanguageState.vietNamese());

  void changedEnglish() => emit(LanguageState.english());

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    return LanguageState(
      isVietnamese: json["isVietnamese"],
    );
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return {
      "isVietnamese": state.isVietnamese,
    };
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
