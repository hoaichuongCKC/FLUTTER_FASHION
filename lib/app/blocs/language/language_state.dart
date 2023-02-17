// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final Locale locale;
  final bool isVietnamese;
  const LanguageState({
    required this.locale,
    required this.isVietnamese,
  });
  factory LanguageState.initial() =>
      const LanguageState(isVietnamese: true, locale: Locale('vi', 'VN'));

  factory LanguageState.vietNamese() =>
      const LanguageState(isVietnamese: true, locale: Locale('vi', 'VN'));

  factory LanguageState.english() =>
      const LanguageState(isVietnamese: false, locale: Locale('en', 'US'));

  @override
  List<Object?> get props => [locale, isVietnamese];
}
