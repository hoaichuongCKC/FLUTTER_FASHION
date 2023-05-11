import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  ValueNotifier<bool> isNotOpenEye = ValueNotifier(true);

  late AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  void dispose() {
    isNotOpenEye.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: formKeyLogin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            key: const ValueKey("phone_form"),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 14.0,
              wordSpacing: 5,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) => _authCubit
                .call(AuthEvent.changedPhone, param: {"phoneNumber": value}),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.phoneNumber,
              prefixIconConstraints: const BoxConstraints(
                minHeight: 20.0,
                maxHeight: 50.0,
                minWidth: 20.0,
                maxWidth: 50.0,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(
                  "assets/icons/phone.svg",
                  fit: BoxFit.scaleDown,
                  width: 24.0,
                  height: 24.0,
                  color: theme.inputDecorationTheme.iconColor,
                ),
              ),
              hintStyle: theme.inputDecorationTheme.hintStyle,
              border: theme.inputDecorationTheme.border,
              fillColor: theme.inputDecorationTheme.fillColor,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Không được để trống";
              }
              return null;
            },
          ),
          const SizedBox(height: 15.0),
          ValueListenableBuilder<bool>(
              valueListenable: isNotOpenEye,
              builder: (context, bool currentEye, child) {
                return TextFormField(
                  key: const ValueKey("password_form"),
                  obscureText: currentEye,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 14.0,
                    wordSpacing: 5,
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (value) {
                    if (validateLogin) {
                      _authCubit.call(AuthEvent.submitLogin, context: context);
                    }
                  },
                  onChanged: (value) => _authCubit.call(
                      AuthEvent.changedPassword,
                      param: {"password": value}),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: theme.inputDecorationTheme.fillColor,
                    border: theme.inputDecorationTheme.border,
                    hintText: AppLocalizations.of(context)!.password,
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 20.0,
                      maxHeight: 50.0,
                      minWidth: 20.0,
                      maxWidth: 50.0,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => isNotOpenEye.value = !currentEye,
                        child: SvgPicture.asset(
                          currentEye
                              ? "assets/icons/eye.svg"
                              : "assets/icons/eye_off.svg",
                          fit: BoxFit.scaleDown,
                          width: 24.0,
                          height: 24.0,
                          // ignore: deprecated_member_use
                          color: theme.inputDecorationTheme.iconColor,
                        ),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minHeight: 20.0,
                      maxHeight: 50.0,
                      minWidth: 20.0,
                      maxWidth: 50.0,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        "assets/icons/lock.svg",
                        fit: BoxFit.scaleDown,
                        width: 24.0,
                        height: 24.0,
                        color: theme.inputDecorationTheme.iconColor,
                      ),
                    ),
                    hintStyle: theme.inputDecorationTheme.hintStyle,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Không được để trống";
                    }
                    return null;
                  },
                );
              }),
        ],
      ),
    );
  }
}
