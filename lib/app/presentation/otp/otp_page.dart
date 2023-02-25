import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';

import '../../../common/components/aurora/aurora_page.dart';
import '../../../export.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {super.key, required this.phoneNumber, required this.verificationId});
  final String phoneNumber;
  final String verificationId;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthPhoneCubit>(),
      child: AuroraBackgroundPage(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14.0, 15.0, 14.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => AppRoutes.pop(),
                  child: const Icon(Icons.arrow_back,
                      size: 30.0, color: darkColor),
                ),
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.enter_otp,
                    style: PrimaryFont.instance.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                Center(
                  child: SvgPicture.asset(
                    "assets/images/authentication_otp.svg",
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  AppLocalizations.of(context)!.otp_code_send_to_the_phone(
                      widget.phoneNumber.toFormattedPhoneNumberVN()),
                  style: PrimaryFont.instance.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 15.0),
                Builder(builder: (context) {
                  return TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    onFieldSubmitted: (value) => context
                        .read<AuthPhoneCubit>()
                        .verifyOtp(widget.phoneNumber, value,
                            widget.verificationId, context),
                    controller: otpController,
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 16,
                      color: darkColor,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: "code",
                      isDense: true,
                      prefixIcon: SvgPicture.asset(
                        "assets/icons/confirm_pass.svg",
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 15),
                const Center(child: Text('Didn\'t get otp code?')),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Send again'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
