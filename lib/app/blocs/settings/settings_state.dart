part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isThemeLight;
  final bool isVietnamese;

  const SettingsState({
    required this.isThemeLight,
    required this.isVietnamese,
  });

  factory SettingsState.fromJson(Map json) {
    return SettingsState(
      isThemeLight: json["isThemeLight"],
      isVietnamese: json["isVietnamese"],
    );
  }

  factory SettingsState.init() {
    return const SettingsState(
      isThemeLight: true,
      isVietnamese: true,
    );
  }
  @override
  List<Object> get props => [isThemeLight, isVietnamese];

  SettingsState copyWith({
    bool? isThemeLight,
    bool? isVietnamese,
  }) {
    return SettingsState(
      isThemeLight: isThemeLight ?? this.isThemeLight,
      isVietnamese: isVietnamese ?? this.isVietnamese,
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      "isThemeLight": isThemeLight,
      "isVietnamese": isVietnamese,
    };
  }
}
