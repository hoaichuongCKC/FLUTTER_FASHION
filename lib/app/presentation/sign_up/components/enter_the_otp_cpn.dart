import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/app/presentation/forgot_password/forgot_password_page.dart';
import 'package:flutter_fashion/app/presentation/sign_up/sign_up_page.dart';

import '../../../../export.dart';

class EnterTheOtpCpn extends StatelessWidget {
  const EnterTheOtpCpn({super.key, this.payload = Names.REGISTER});
  final String payload;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final phone = payload == Names.REGISTER
        ? SignUpPage.phoneNumber
        : ForgotPasswordPage.phoneNumber;

    return BlocListener<AuthPhoneCubit, AuthPhoneState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          error: () {},
          authPhoneSuccess: () {},
          verifyOtpSuccess: () {
            if (payload == Names.REGISTER) {
              SignUpPage.currentStep.value++;
              return;
            }
            ForgotPasswordPage.currentStep.value++;
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!
                .otp_code_send_to_the_phone(phone.toFormattedPhoneNumberVN()),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: (value) {
              if (payload == Names.FORGOT_PASSWORD) {
                ForgotPasswordPage.codeOTP = value;
                return;
              }
              SignUpPage.codeOTP = value;
            },
            onFieldSubmitted: (code) {
              if (validateSignUp) {
                final bloc = context.read<AuthPhoneCubit>();

                bloc.verifyOtp(
                  SignUpPage.phoneNumber,
                  code,
                  context,
                  SignUpPage.verificationId,
                );
              }
            },
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: "code",
              isDense: true,
              prefixIcon: SvgPicture.asset(
                "assets/icons/confirm_pass.svg",
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
