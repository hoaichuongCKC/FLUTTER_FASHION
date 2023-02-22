import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: AuroraBackgroundPage(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ConstrainedBoxWidget(
                minHeight: 100,
                maxHeight: 150,
                currentHeight: 0.15,
              ),
              SvgPicture.asset(
                "assets/images/app_logo.svg",
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "KiraStore",
                    style: PrimaryFont.instance.large(),
                  ),
                ),
              ),
              FormLogin(
                formKey: formKey,
                passwordController: _passwordController,
                phoneController: _phoneController,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    AppSnackbarMessenger.showMessage(content: "Hello bà già");
                  },
                  child: Text(AppLocalizations.of(context)!.signUp),
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    current.status == AppStatus.init,
                builder: (context, state) {
                  bool isDisable =
                      state.phoneNumber.isNotEmpty && state.password.isNotEmpty;
                  return ButtonWidget(
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.5),
                        offset: const Offset(2, 4),
                        blurRadius: 10,
                      ),
                    ],
                    btnColor: !isDisable ? disablePrimaryColor : primaryColor,
                    onPressed: !isDisable
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().call(
                                  AuthEvent.submitLogin,
                                  context: context);
                            }
                          },
                    animate: true,
                    label: AppLocalizations.of(context)!.login,
                  );
                },
              ),
              const SizedBox(height: 50.0),
              const FooterLogin(),
              if (MediaQuery.of(context).size.height < 720.0)
                const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
