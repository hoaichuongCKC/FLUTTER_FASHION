import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              FormLogin(formKey: formKey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => AppRoutes.router.push(
                      Routes.SIGNUP,
                      extra: Names.FORGOT_PASSWORD,
                    ),
                    child: Text(
                        "${AppLocalizations.of(context)!.forgot_password}?"),
                  ),
                  TextButton(
                    onPressed: () => AppRoutes.router.push(
                      Routes.SIGNUP,
                      extra: Names.REGISTER,
                    ),
                    child: Text(AppLocalizations.of(context)!.signUp),
                  ),
                ],
              ),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    current.status == AppStatus.init,
                builder: (context, state) {
                  bool isDisable =
                      state.phoneNumber.isNotEmpty && state.password.isNotEmpty;
                  return ButtonWidget(
                    boxShadow: [
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
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().call(
                                  AuthEvent.submitLogin,
                                  context: context);
                            }
                          },
                    animate: true,
                    label: AppLocalizations.of(context)!.login,
                  );
                },
              ),
              const SizedBox(height: 50.0),
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
