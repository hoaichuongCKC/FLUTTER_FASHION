import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/common/widgets/text_form_field_app.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Builder(builder: (context) {
          final loginBloc = context.read<AuthCubit>();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    applocalization.login,
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                  TextFormFieldApp(
                    title: applocalization.phoneNumber,
                    textInputAction: TextInputAction.next,
                    prefixIcon: SvgPicture.asset(
                      "assets/icons/phone.svg",
                      fit: BoxFit.scaleDown,
                      width: 12,
                      height: 12.0,
                    ),
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.phone,
                    hintText: "VD: 0918.....",
                    onChanged: (value) => loginBloc.call(
                      AuthEvent.changedPhone,
                      param: {"phoneNumber": value},
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormFieldApp(
                    obscureText: true,
                    title: applocalization.password,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "******",
                    prefixIcon: SvgPicture.asset(
                      "assets/icons/lock.svg",
                      fit: BoxFit.scaleDown,
                      width: 12,
                      height: 12.0,
                    ),
                    onChanged: (value) => loginBloc.call(
                      AuthEvent.changedPassword,
                      param: {"password": value},
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.read<AuthCubit>().reset();
                        AppRoutes.router.push(Routes.FORGOT_PASSWORD);
                      },
                      child: Text(
                        "${applocalization.forgot_password}?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        current.status == AppStatus.init,
                    builder: (context, state) {
                      final bool isNotDisable = state.phoneNumber.isNotEmpty &&
                          state.password.isNotEmpty;

                      final onPressed = isNotDisable
                          ? () {
                              context.read<AuthCubit>().call(
                                  AuthEvent.submitLogin,
                                  context: context);
                            }
                          : null;
                      return ButtonWidget(
                        onPressed: onPressed,
                        background:
                            isNotDisable ? null : secondaryColor.withAlpha(100),
                        child: Text(
                          AppLocalizations.of(context)!.login.toUpperCase(),
                          style: PrimaryFont.instance.copyWith(
                            color: lightColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        context.read<AuthCubit>().reset();
                        AppRoutes.router.push(Routes.SIGNUP);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${applocalization.signUp}?",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const Icon(
                            Icons.arrow_right_alt,
                            size: 20.0,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  const FooterLogin(),
                  const Spacer(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
