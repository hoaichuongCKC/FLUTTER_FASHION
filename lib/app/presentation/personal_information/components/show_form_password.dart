import 'package:flutter_fashion/app/blocs/change_password/change_password_cubit.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';
import 'package:flutter_fashion/utils/alert/error.dart';

class FormChangePassword extends StatefulWidget {
  const FormChangePassword({super.key});

  @override
  State<FormChangePassword> createState() => _FormChangePasswordState();
}

class _FormChangePasswordState extends State<FormChangePassword> {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    currentPassword.dispose();
    confirmPassword.dispose();
    newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordCubit>(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radiusBtn)),
          ),
          insetPadding: EdgeInsets.zero,
          titleTextStyle: PrimaryFont.instance.large(),
          icon: Image.asset(
            "assets/images/admin.png",
            width: 30,
            height: 30,
          ),
          title: Text(
            AppLocalizations.of(context)!.changePassword,
          ),
          content: Builder(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ShowInputPassword(
                  iconUrl: "assets/icons/lock.svg",
                  hintText: AppLocalizations.of(context)!.currentPassword,
                  controller: currentPassword,
                  key: const ValueKey("change_form_current_pasword"),
                  onChanged: (value) => context
                      .read<ChangePasswordCubit>()
                      .onChangedCurrentPassword(value),
                ),
                const SizedBox(height: 10.0),
                ShowInputPassword(
                  iconUrl: "assets/icons/lock.svg",
                  hintText: AppLocalizations.of(context)!.newPassword,
                  controller: newPassword,
                  key: const ValueKey("change_form_new_pasword"),
                  onChanged: (value) => context
                      .read<ChangePasswordCubit>()
                      .onChangedNewPassword(value),
                ),
                const SizedBox(height: 10.0),
                ShowInputPassword(
                  iconUrl: "assets/icons/confirm_pass.svg",
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                  controller: confirmPassword,
                  key: const ValueKey("change_form_confirm_pasword"),
                  onChanged: (value) => context
                      .read<ChangePasswordCubit>()
                      .onChangedConfirmPassword(value),
                ),
                const SizedBox(height: 15.0),
                BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) {
                    bool isCheckParam = state.currentPass.isNotEmpty &&
                        state.confirmPass.isNotEmpty &&
                        state.newPass.isNotEmpty;

                    return ButtonWidget(
                      height: 40.0,
                      onPressed: !isCheckParam
                          ? null
                          : () {
                              final bool isValidPassword =
                                  newPassword.text.isValidPassword ||
                                      confirmPassword.text.isValidPassword;

                              if (!isValidPassword) {
                                errorAlert(
                                  context: context,
                                  counter: 4,
                                  message: AppLocalizations.of(context)!
                                      .text_validate_valid_pass,
                                );
                                return;
                              }
                              if (newPassword.text != confirmPassword.text) {
                                errorAlert(
                                  context: context,
                                  message: AppLocalizations.of(context)!
                                      .theNewPasswordDoesNotMatch,
                                );
                                return;
                              }
                              final bloc = context.read<ChangePasswordCubit>();
                              bloc.submitForm(context);
                            },
                      labelWidget: Text(
                        AppLocalizations.of(context)!.change,
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: lightColor,
                        ),
                      ),
                      btnColor: isCheckParam
                          ? primaryColor
                          : primaryColor.withOpacity(0.4),
                    );
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class ShowInputPassword extends StatefulWidget {
  const ShowInputPassword(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.iconUrl,
      required this.onChanged});

  final String hintText;
  final String iconUrl;
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  State<ShowInputPassword> createState() => _ShowInputPasswordState();
}

class _ShowInputPasswordState extends State<ShowInputPassword> {
  bool _isVisibility = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      child: TextFormField(
        key: widget.key,
        controller: widget.controller,
        obscureText: _isVisibility,
        style: PrimaryFont.instance.copyWith(
          fontSize: 14.0,
          color: darkColor,
          fontWeight: FontWeight.w300,
          wordSpacing: 5,
        ),
        onChanged: (value) => widget.onChanged(value),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password incorrect";
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: lightColor,
          hintText: widget.hintText,
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
              onTap: () => setState(() {
                _isVisibility = !_isVisibility;
              }),
              customBorder: const CircleBorder(),
              child: SvgPicture.asset(
                _isVisibility
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
              widget.iconUrl,
              fit: BoxFit.contain,
              width: 24.0,
              height: 24.0,
            ),
          ),
          hintStyle: PrimaryFont.instance.copyWith(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: disableDarkColor,
          ),
        ),
      ),
    );
  }
}
