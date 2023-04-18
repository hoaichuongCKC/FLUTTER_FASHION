import 'package:flutter_fashion/app/blocs/auth_phone/auth_phone_cubit.dart';
import 'package:flutter_fashion/export.dart';
import '../../../common/components/aurora/aurora_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.payload});
  final String payload;
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
    String text = AppLocalizations.of(context)!.signUp;
    if (widget.payload != Names.REGISTER) {
      text = AppLocalizations.of(context)!.forgot_password;
    }

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
                      text,
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
                          final bloc = context.read<AuthPhoneCubit>();

                          bloc.authPhone(value, context, widget.payload);
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
                          final bloc = context.read<AuthPhoneCubit>();
                          final text = _phoneController.text;
                          bloc.authPhone(text, context, widget.payload);
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
