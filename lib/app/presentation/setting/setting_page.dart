// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/presentation/setting/export.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return BaseAppBackground(
      title: AppLocalizations.of(context)!.setting,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15.0),
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return ItemSetting(
                title: AppLocalizations.of(context)!.language,
                isToggled: state.isVietnamese,
                titleTrailing: state.isVietnamese ? "Việt Nam" : "English",
                subtitle: AppLocalizations.of(context)!
                    .theDefaultLanguageIsVietnamese,
                excute: () {
                  if (state.isVietnamese) {
                    context.read<LanguageCubit>().changedEnglish();
                  } else {
                    context.read<LanguageCubit>().changedVietnamese();
                  }
                },
                color: const Color(0xFFFF9F43),
                icon: SvgPicture.asset("assets/icons/setting/language.svg"),
              );
            },
          ),
          const SizedBox(height: 15.0),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return ItemSetting(
                isToggled: state.isLight,
                title: AppLocalizations.of(context)!.darkMode,
                titleTrailing: state.isLight
                    ? AppLocalizations.of(context)!.turnOff
                    : AppLocalizations.of(context)!.turnOn,
                excute: () {
                  if (state.isLight) {
                    context.read<ThemeCubit>().darkTheme();
                  } else {
                    context.read<ThemeCubit>().lightTheme();
                  }
                },
                color: primaryColor,
                icon: SvgPicture.asset("assets/icons/setting/moon.svg"),
              );
            },
          ),
          const SizedBox(height: 15.0),
          ItemSetting(
            title: AppLocalizations.of(context)!.notificationPage,
            titleTrailing: AppLocalizations.of(context)!.sound,
            excute: () {},
            color: const Color(0xFFFF7043),
            icon: SvgPicture.asset("assets/icons/notification.svg",
                color: const Color(0xFFFF7043)),
          ),
        ],
      ),
    );
  }
}
