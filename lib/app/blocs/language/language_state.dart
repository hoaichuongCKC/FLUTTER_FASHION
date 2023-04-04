// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final bool isVietnamese;
  final String locale;
  const LanguageState({
    required this.isVietnamese,
    required this.locale,
  });
  factory LanguageState.initial() => const LanguageState(
        isVietnamese: true,
        locale: "vi-VN",
      );

  factory LanguageState.vietNamese() => const LanguageState(
        isVietnamese: true,
        locale: "vi_VN",
      );

  factory LanguageState.english() =>
      const LanguageState(isVietnamese: false, locale: "en_US");

  @override
  List<Object?> get props => [isVietnamese, locale];
}
