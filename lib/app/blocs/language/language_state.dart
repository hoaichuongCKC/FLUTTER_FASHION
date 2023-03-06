// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final bool isVietnamese;
  const LanguageState({
    required this.isVietnamese,
  });
  factory LanguageState.initial() => const LanguageState(
        isVietnamese: true,
      );

  factory LanguageState.vietNamese() => const LanguageState(isVietnamese: true);

  factory LanguageState.english() => const LanguageState(isVietnamese: false);

  @override
  List<Object?> get props => [isVietnamese];
}
