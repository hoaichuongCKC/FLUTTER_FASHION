import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/app/presentation/forgot_password/forgot_password_page.dart';
import 'package:flutter_fashion/app/presentation/sign_up/sign_up_page.dart';

import '../../../../export.dart';

class EnterThePhoneCpn extends StatelessWidget {
  const EnterThePhoneCpn({super.key, this.payload = Names.REGISTER});
  final String payload;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AuthPhoneCubit, AuthPhoneState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          error: () {},
          authPhoneSuccess: () {
            if (payload == Names.REGISTER) {
              SignUpPage.currentStep.value++;
              return;
            }
            ForgotPasswordPage.currentStep.value++;
          },
          verifyOtpSuccess: () {},
        );
      },
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.phone,
        onFieldSubmitted: (value) {
          if (!validateSignUp) return;
          final bloc = context.read<AuthPhoneCubit>();

          bloc.phoneAuth(value, context, payload);
        },
        style: theme.textTheme.bodySmall!.copyWith(
          fontSize: 14,
        ),
        onChanged: (value) {
          if (payload == Names.REGISTER) {
            SignUpPage.phoneNumber = value;
            return;
          }
          ForgotPasswordPage.phoneNumber = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Incorrect!!";
          }
          return null;
        },
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: SvgPicture.asset(
            "assets/icons/phone.svg",
            width: 24.0,
            height: 24.0,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              theme.inputDecorationTheme.iconColor!,
              BlendMode.srcIn,
            ),
          ),
          hintText: AppLocalizations.of(context)!.phoneNumber,
          hintStyle: theme.inputDecorationTheme.hintStyle,
        ),
      ),
    );
  }
}
