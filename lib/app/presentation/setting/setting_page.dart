import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';
import 'package:flutter_fashion/app/presentation/setting/export.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.watch<UserCubit>().user;
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Builder(builder: (context) {
        return AppBackgroundBlur.normal(
          title: AppLocalizations.of(context)!.setting,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15.0),
                BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (p, c) => p.isVietnamese != c.isVietnamese,
                  builder: (context, settings) {
                    return ItemSetting(
                      title: AppLocalizations.of(context)!.language,
                      isToggled: !settings.isVietnamese,
                      titleTrailing:
                          settings.isVietnamese ? "Việt Nam" : "English",
                      subtitle: AppLocalizations.of(context)!
                          .theDefaultLanguageIsVietnamese,
                      excute: () =>
                          context.read<SettingsCubit>().changeLanguage(),
                      color: const Color(0xFFFF9F43),
                      icon:
                          SvgPicture.asset("assets/icons/setting/language.svg"),
                    );
                  },
                ),
                const SizedBox(height: 15.0),
                BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (p, c) => p.isThemeLight != c.isThemeLight,
                  builder: (context, settings) {
                    return ItemSetting(
                      isToggled: !settings.isThemeLight,
                      title: AppLocalizations.of(context)!.darkMode,
                      titleTrailing: !settings.isThemeLight ? "" : "",
                      excute: () => context.read<SettingsCubit>().changeTheme(),
                      color: primaryColor,
                      icon: SvgPicture.asset("assets/icons/setting/moon.svg"),
                    );
                  },
                ),
                const SizedBox(height: 15.0),
                BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (p, c) => p.isPlaySound != c.isPlaySound,
                  builder: (context, settings) {
                    return ItemSetting(
                      isToggled: settings.isPlaySound,
                      title: AppLocalizations.of(context)!.notificationPage,
                      titleTrailing: AppLocalizations.of(context)!.sound,
                      excute: () =>
                          context.read<SettingsCubit>().changePlaySound(),
                      color: const Color(0xFFFF7043),
                      icon: SvgPicture.asset(
                        "assets/icons/notification.svg",
                        // ignore: deprecated_member_use
                        color: const Color(0xFFFF7043),
                      ),
                    );
                  },
                ),
                user.login_provider == googleProvider
                    ? const SizedBox()
                    : const SizedBox(height: 15.0),
                user.login_provider == googleProvider
                    ? const SizedBox()
                    : ItemSetting(
                        isHasToggled: false,
                        title: AppLocalizations.of(context)!.changePassword,
                        trailing: SvgPicture.asset(
                          "assets/icons/arrow_right.svg",
                          colorFilter: ColorFilter.mode(
                            theme.iconTheme.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                        excute: () => AppRoutes.router.push(
                            "${Routes.PROFILE}/${Routes.SETTING}/${Routes.CHANGE_PASSWORD}"),
                        color: const Color.fromARGB(255, 211, 54, 140),
                        icon: const Icon(
                          Icons.lock,
                          size: 18.0,
                          color: Color.fromARGB(255, 211, 54, 140),
                        ),
                      ),
                const SizedBox(height: 15.0),
                ItemSetting(
                  isHasToggled: false,
                  title: AppLocalizations.of(context)!.logout,
                  trailing: SvgPicture.asset(
                    "assets/icons/arrow_right.svg",
                    colorFilter: ColorFilter.mode(
                      theme.iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                  excute: () => showDialogNotiLogout(context),
                  color: const Color(0xFF2B93F3),
                  icon: const Icon(
                    Icons.logout_rounded,
                    size: 18.0,
                    color: Color(0xFF2B93F3),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

showDialogNotiLogout(BuildContext context) {
  popupAlert(
    context: context,
    message: AppLocalizations.of(context)!.are_you_sure_to_log_out,
    onCancel: () => AppRoutes.router.pop(),
    onPressed: () {
      AppRoutes.router.pop();
      loadingAlert(context: context);
      context.read<AuthCubit>().call(AuthEvent.loggout, context: context);
    },
  );
}
