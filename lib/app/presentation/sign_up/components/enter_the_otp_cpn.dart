import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/app/presentation/forgot_password/forgot_password_page.dart';
import 'package:flutter_fashion/app/presentation/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter_fashion/app/presentation/sign_up/sign_up_page.dart';
import 'package:pinput/pinput.dart';
import '../../../../export.dart';

class EnterTheOtpCpn extends StatefulWidget {
  const EnterTheOtpCpn({super.key, this.payload = Names.REGISTER});
  final String payload;

  @override
  State<EnterTheOtpCpn> createState() => EnterTheOtpCpnState();
}

class EnterTheOtpCpnState extends State<EnterTheOtpCpn> {
  /// Create Controller
  // ignore: prefer_typing_uninitialized_variables
  late final pinController;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final phone = widget.payload == Names.REGISTER
        ? SignUpPage.phoneNumber
        : ForgotPasswordPage.phoneNumber;

    final bloc = context.read<SignUpUICubit>();

    final authbloc = context.read<AuthPhoneCubit>();

    final size = MediaQuery.of(context).size;

    final defaultPinTheme = PinTheme(
      width: size.width * 0.2,
      height: size.width * 0.2,
      textStyle: theme.textTheme.bodySmall!.copyWith(
        fontSize: 14.0,
        color: secondaryColor,
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(radiusBtn),
          boxShadow: [shadowBox]),
      constraints: const BoxConstraints(
        minHeight: 48.0,
        maxHeight: 53.0,
        minWidth: 48.0,
        maxWidth: 53.0,
      ),
    );

    return BlocListener<AuthPhoneCubit, AuthPhoneState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          error: () {},
          authPhoneSuccess: () {},
          verifyOtpSuccess: () {
            if (widget.payload == Names.REGISTER) {
              bloc.nextStep(SignUpUIState.fillingInfor);
              return;
            }
            bloc.nextStep(SignUpUIState.fillingInfor);
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
          Pinput(
            controller: pinController,
            length: 6,
            onChanged: (code) {
              if (widget.payload == Names.FORGOT_PASSWORD) {
                ForgotPasswordPage.codeOTP = code;
              } else {
                SignUpPage.codeOTP = code;
              }
            },
            onCompleted: (code) {
              if (widget.payload == Names.FORGOT_PASSWORD) {
                authbloc.verifyOtp(
                    phone, code, context, ForgotPasswordPage.verificationId);
              } else {
                authbloc.verifyOtp(
                    phone, code, context, SignUpPage.verificationId);
              }
            },
            defaultPinTheme: defaultPinTheme,
            showCursor: true,
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
          ),
          const SizedBox(height: 15.0),
          InkWell(
            onTap: () {
              final bloc = context.read<AuthPhoneCubit>();
              bloc.phoneAuth(SignUpPage.phoneNumber, context, Names.REGISTER);
            },
            child: Center(
              child: Text(
                "Gửi lại mã OTP? 0:49",
                style: theme.textTheme.bodySmall,
              ),
            ),
          )
        ],
      ),
    );
  }
}
