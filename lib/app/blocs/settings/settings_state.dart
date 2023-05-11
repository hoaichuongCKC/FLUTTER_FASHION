part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isThemeLight;
  final bool isVietnamese;
  final bool isPlaySound;

  const SettingsState({
    required this.isThemeLight,
    required this.isVietnamese,
    required this.isPlaySound,
  });

  factory SettingsState.fromJson(Map json) {
    return SettingsState(
      isThemeLight: json["isThemeLight"],
      isVietnamese: json["isVietnamese"],
      isPlaySound: json["isPlaySound"],
    );
  }

  factory SettingsState.init() {
    return const SettingsState(
      isThemeLight: true,
      isVietnamese: true,
      isPlaySound: true,
    );
  }
  @override
  List<Object> get props => [isThemeLight, isVietnamese, isPlaySound];

  SettingsState copyWith({
    bool? isThemeLight,
    bool? isVietnamese,
    bool? isPlaySound,
  }) {
    return SettingsState(
      isThemeLight: isThemeLight ?? this.isThemeLight,
      isVietnamese: isVietnamese ?? this.isVietnamese,
      isPlaySound: isPlaySound ?? this.isPlaySound,
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      "isThemeLight": isThemeLight,
      "isVietnamese": isVietnamese,
      "isPlaySound": isPlaySound,
    };
  }
}
