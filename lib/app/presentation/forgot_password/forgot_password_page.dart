import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/common/components/aurora/aurora_page.dart';
import 'package:flutter_fashion/export.dart';

import '../personal_information/components/show_form_password.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    confirmPassword.dispose();
    newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Builder(builder: (context) {
        return AuroraBackgroundPage(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(14.0, 5.0, 14.0, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => AppRoutes.router.pop(),
                      child: const Icon(Icons.arrow_back,
                          size: 24.0, color: darkColor),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      AppLocalizations.of(context)!.forgot_password,
                      style: PrimaryFont.instance.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/Forgot password-amico.svg",
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    ShowInputPassword(
                      iconUrl: "assets/icons/lock.svg",
                      hintText: AppLocalizations.of(context)!.newPassword,
                      controller: newPassword,
                      key: const ValueKey("change_form_current_pasword"),
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15.0),
                    ShowInputPassword(
                      iconUrl: "assets/icons/lock.svg",
                      hintText: AppLocalizations.of(context)!.confirmPassword,
                      controller: confirmPassword,
                      key: const ValueKey("change_form_new_pasword"),
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 20.0),
                    ButtonWidget(
                      btnColor: primaryColor,
                      onPressed: () {
                        final validate = _formKey.currentState!.validate();
                        if (validate) {
                          final bloc = BlocProvider.of<AuthCubit>(context);
                          bloc.forgotPassword(
                              context, widget.phoneNumber, newPassword.text);
                        }
                      },
                      animate: true,
                      label: AppLocalizations.of(context)!.change,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
