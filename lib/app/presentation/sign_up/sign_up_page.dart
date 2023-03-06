import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/export.dart';
import '../../../common/components/aurora/aurora_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthPhoneCubit>(),
      child: Builder(builder: (context) {
        return AuroraBackgroundPage(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(14.0, 15.0, 14.0, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => AppRoutes.pop(),
                      child: const Icon(Icons.arrow_back,
                          size: 30.0, color: darkColor),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      AppLocalizations.of(context)!.signUp,
                      style: PrimaryFont.instance.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/authentication_phone.svg",
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: _phoneController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      style: PrimaryFont.instance.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
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
                        ),
                        hintText: AppLocalizations.of(context)!.phoneNumber,
                        hintStyle: PrimaryFont.instance.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: darkColor.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ButtonWidget(
                      animate: false,
                      height: 45.0,
                      label: AppLocalizations.of(context)!.continue_r,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // print(FirebaseAuth.instance.currentUser);
                          // context
                          //     .read<AuthPhoneCubit>()
                          //     .authPhone(_phoneController.text, context);
                          AppRoutes.pushNamed(Names.REGISTER,
                              queryParams: {"phone": _phoneController.text});
                          // FirebaseAuth.instance.signOut();
                        }
                      },
                      btnColor: primaryColor,
                    ),
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

// Future<String?> sendOtp(String phoneNumber) async {
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

//   // Lấy token của thiết bị để gửi thông báo đến
//   String? token = await firebaseMessaging.getToken(
//       vapidKey:
//           "BHFVr5iKSRCiXYTx35Id1HVXn8Yiz41q1A1plKK5eQFn2eqVMIv5ALGyk0EhDOGkPjfHKbTTQxqbnZzMBT3C92A");
//   print(token);
//   if (token == null) {
//     return null;
//   }

//   // Tạo payload chứa mã OTP và số điện thoại
//   final payload = {
//     'phoneNumber': phoneNumber,
//     'otp': generateOtp(),
//   };

//   // Gửi thông báo đẩy chứa payload
//   await firebaseMessaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//   await firebaseMessaging.sendMessage(
//     to: token,
//     data: payload,
//   );

//   return payload['otp'];
// }

// String generateOtp() {
//   return "121212";
// }
