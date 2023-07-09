import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/app/presentation/forgot_password/forgot_password_page.dart';
import 'package:flutter_fashion/app/presentation/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter_fashion/app/presentation/sign_up/sign_up_page.dart';
import 'package:flutter_fashion/common/widgets/text_form_field_app.dart';

import '../../../../config/svg_files.dart';
import '../../../../export.dart';

class EnterThePhoneCpn extends StatelessWidget {
  const EnterThePhoneCpn({super.key, this.payload = Names.REGISTER});
  final String payload;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpUICubit>();

    final applocalization = AppLocalizations.of(context)!;

    return BlocListener<AuthPhoneCubit, AuthPhoneState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          error: () {},
          authPhoneSuccess: () {
            if (payload == Names.REGISTER) {
              bloc.nextStep(SignUpUIState.enterOTP);
              return;
            }
            bloc.nextStep(SignUpUIState.enterOTP);
          },
          verifyOtpSuccess: () {},
        );
      },
      child: TextFormFieldApp(
        title: applocalization.phoneNumber,
        textInputAction: TextInputAction.next,
        inputFormatter: [
          LengthLimitingTextInputFormatter(10),
        ],
        keyboardType: TextInputType.phone,
        hintText: "VD: 0918.....",
        prefixIcon: SvgPicture.asset(
          Assets.phoneSVG,
          fit: BoxFit.scaleDown,
          width: 12,
          height: 12.0,
        ),
        onChanged: (value) {
          if (payload == Names.REGISTER) {
            SignUpPage.phoneNumber = value;
            return;
          }
          ForgotPasswordPage.phoneNumber = value;
        },
      ),
    );
  }
}
