// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final bool isDark;

  const ThemeState({
    required this.isDark,
  });

  factory ThemeState.initial() => const ThemeState(isDark: false);

  factory ThemeState.light() => const ThemeState(isDark: false);
  factory ThemeState.dark() => const ThemeState(isDark: true);

  @override
  List<Object?> get props => [isDark];
}
