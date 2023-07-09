import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/export.dart';
part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState.init());

  void changeLanguage() =>
      emit(state.copyWith(isVietnamese: !state.isVietnamese));

  void changeTheme() {
    final bool isLight = !state.isThemeLight;

    if (isLight) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: blackColor,
        statusBarIconBrightness: Brightness.light,
      ));
    }

    ThemeDataApp.instance.setLightTheme = isLight;

    emit(state.copyWith(isThemeLight: isLight));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }
}
