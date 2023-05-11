import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: AuroraBackgroundPage(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ConstrainedBoxWidget(
                minHeight: 60,
                maxHeight: 80,
                currentHeight: 0.15,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 200.0,
                height: 200.0,
              ),
              const FormLogin(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => AppRoutes.router.push(
                    Routes.SIGNUP,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.signUp,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    current.status == AppStatus.init,
                builder: (context, state) {
                  bool isDisable =
                      state.phoneNumber.isNotEmpty && state.password.isNotEmpty;
                  return ButtonWidget(
                    boxShadow: !ThemeDataApp.instance.isLight
                        ? null
                        : [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.5),
                              offset: const Offset(2, 4),
                              blurRadius: 10,
                            ),
                          ],
                    btnColor: !isDisable ? disablePrimaryColor : primaryColor,
                    onPressed: !isDisable
                        ? null
                        : () {
                            if (validateLogin) {
                              context.read<AuthCubit>().call(
                                  AuthEvent.submitLogin,
                                  context: context);
                            }
                          },
                    animate: isDisable,
                    label: AppLocalizations.of(context)!.login,
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () => AppRoutes.router.push(
                    Routes.FORGOT_PASSWORD,
                  ),
                  child: Text(
                    "${AppLocalizations.of(context)!.forgot_password}?",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              const SizedBox(height: 35.0),
              const FooterLogin(),
              if (MediaQuery.of(context).size.height < 720.0)
                const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
