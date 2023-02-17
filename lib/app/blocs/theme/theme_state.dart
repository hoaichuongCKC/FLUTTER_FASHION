// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final bool isLight;

  const ThemeState({
    required this.isLight,
  });

  factory ThemeState.initial() => const ThemeState(isLight: true);

  factory ThemeState.light() => const ThemeState(isLight: true);
  factory ThemeState.dark() => const ThemeState(isLight: false);

  @override
  List<Object?> get props => [isLight];
}
