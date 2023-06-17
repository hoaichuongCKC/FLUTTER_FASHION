import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/app/presentation/forgot_password/components/setup_new_password.dart';
import 'package:flutter_fashion/app/presentation/forgot_password/forgot_password_page.dart';
import 'package:flutter_fashion/app/presentation/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter_fashion/export.dart';

class ButtonSubmitForgot extends StatelessWidget {
  const ButtonSubmitForgot({super.key});

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    final bloc = context.read<AuthPhoneCubit>();

    final authBloc = context.read<AuthCubit>();

    final blocListen = context.watch<SignUpUICubit>();
    return ButtonWidget(
      onPressed: () {
        if (blocListen.state == 0) {
          bloc.phoneAuth(
              ForgotPasswordPage.phoneNumber, context, Names.FORGOT_PASSWORD);
        }
        if (blocListen.state == 1) {
          bloc.verifyOtp(
            ForgotPasswordPage.phoneNumber,
            ForgotPasswordPage.codeOTP,
            context,
            ForgotPasswordPage.verificationId,
          );
        }
        if (blocListen.state == 2) {
          if (SetupNewPasswordCpn.validate) {
            if (SetupNewPasswordCpn.password.isValidPassword) {
              authBloc.forgotPassword(context, ForgotPasswordPage.phoneNumber,
                  SetupNewPasswordCpn.password);
            } else {
              showErrorToast(applocalization.text_validate_valid_pass);
            }
            return;
          }
          showErrorToast(applocalization.password_not_match);
        }
      },
      child: Text(
        (blocListen.state == 2)
            ? applocalization.completed
            : applocalization.continue_r,
        style: textTheme.bodyMedium!.copyWith(
          fontSize: 14.0,
          color: lightColor,
        ),
      ),
    );
  }
}
