import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  GlobalKey<FormState> get _formKey => widget.formKey;

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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            key: const ValueKey("phone_form"),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            style: PrimaryFont.instance.copyWith(
              fontSize: 16.0,
              color: darkColor,
              fontWeight: FontWeight.w300,
              wordSpacing: 5,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) => _authCubit
                .call(AuthEvent.changedPhone, param: {"phoneNumber": value}),
            decoration: InputDecoration(
              filled: true,
              fillColor: lightColor,
              hintText: AppLocalizations.of(context)!.phoneNumber,
              prefixIconConstraints: const BoxConstraints(
                minHeight: 20.0,
                maxHeight: 50.0,
                minWidth: 20.0,
                maxWidth: 50.0,
              ),
              isDense: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SvgPicture.asset(
                  "assets/icons/phone.svg",
                  fit: BoxFit.contain,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              hintStyle: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: disableDarkColor,
              ),
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
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 16.0,
                    color: darkColor,
                    fontWeight: FontWeight.w300,
                    wordSpacing: 5,
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (value) => context
                      .read<AuthCubit>()
                      .call(AuthEvent.submitLogin, context: context),
                  onChanged: (value) => _authCubit.call(
                      AuthEvent.changedPassword,
                      param: {"password": value}),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: lightColor,
                    hintText: AppLocalizations.of(context)!.password,
                    isDense: true,
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 20.0,
                      maxHeight: 50.0,
                      minWidth: 20.0,
                      maxWidth: 50.0,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => isNotOpenEye.value = !currentEye,
                        child: SvgPicture.asset(
                          currentEye
                              ? "assets/icons/eye.svg"
                              : "assets/icons/eye_off.svg",
                          fit: BoxFit.contain,
                          width: 40.0,
                          height: 40.0,
                          // ignore: deprecated_member_use
                          color: primaryColor,
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
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: SvgPicture.asset(
                        "assets/icons/lock.svg",
                        fit: BoxFit.contain,
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                    hintStyle: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: disableDarkColor,
                    ),
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
