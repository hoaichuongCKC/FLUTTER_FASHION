import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';
import 'package:flutter_fashion/app/presentation/setting/export.dart';
import 'package:flutter_fashion/config/svg_files.dart';
import 'package:flutter_fashion/utils/alert/dialog.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.watch<UserCubit>().user;
    final applocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Builder(
        builder: (context) {
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
                        title: applocalizations.language,
                        isToggled: !settings.isVietnamese,
                        titleTrailing:
                            settings.isVietnamese ? "Việt Nam" : "English",
                        subtitle:
                            applocalizations.theDefaultLanguageIsVietnamese,
                        excute: () =>
                            context.read<SettingsCubit>().changeLanguage(),
                        color: const Color(0xFFFF9F43),
                        icon: SvgPicture.asset(Assets.languageSVG),
                      );
                    },
                  ),
                  const SizedBox(height: 15.0),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    buildWhen: (p, c) => p.isThemeLight != c.isThemeLight,
                    builder: (context, settings) {
                      return ItemSetting(
                        isToggled: !settings.isThemeLight,
                        title: applocalizations.darkMode,
                        titleTrailing: !settings.isThemeLight ? "" : "",
                        excute: () =>
                            context.read<SettingsCubit>().changeTheme(),
                        color: const Color(0xFF8E8EEB),
                        icon: SvgPicture.asset(Assets.moonSVG),
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
                          title: applocalizations.changePassword,
                          trailing: SvgPicture.asset(
                            Assets.arrowRightSVG,
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
                    title: applocalizations.logout,
                    trailing: SvgPicture.asset(
                      Assets.arrowRightSVG,
                      colorFilter: ColorFilter.mode(
                        theme.iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                    excute: () => showCustomDialog(
                      context,
                      content: applocalizations.are_you_sure_to_log_out,
                      title: applocalizations.logout,
                      submitNameFirst: applocalizations.cancel,
                      submitNameSecond: applocalizations.ok,
                      onFirst: () => AppRoutes.router.pop(),
                      onSecond: () {
                        AppRoutes.router.pop();
                        loadingAlert(context: context);
                        context
                            .read<AuthCubit>()
                            .call(AuthEvent.loggout, context: context);
                      },
                    ),
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
        },
      ),
    );
  }
}
