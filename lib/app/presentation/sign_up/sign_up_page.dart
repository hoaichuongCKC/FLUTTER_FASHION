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
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<AuthPhoneCubit>()
                              .authPhone(value, context);
                        }
                      },
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
                      animate: true,
                      height: 45.0,
                      label: AppLocalizations.of(context)!.continue_r,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // print(FirebaseAuth.instance.currentUser);
                          // context
                          //     .read<AuthPhoneCubit>()
                          //     .authPhone(_phoneController.text, context);
                          AppRoutes.router.pushNamed(Names.OTP, queryParams: {
                            "phone": _phoneController.text,
                            "verificationId": "1",
                          });
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
