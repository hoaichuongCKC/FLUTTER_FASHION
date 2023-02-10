import 'package:flutter_fashion/app/routes/app_routes.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return AuroraBackgroundPage(
      child: SafeArea(
        child: SizedBox.expand(
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
                FormLogin(formKey: formKey),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Đăng kí'),
                  ),
                ),
                ButtonWidget(
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.5),
                      offset: const Offset(2, 4),
                      blurRadius: 10,
                    ),
                  ],
                  onPressed: () {
                    AppRoutes.go(Routes.HOME);
                    if (formKey.currentState!.validate()) {}
                  },
                  label: 'Đăng nhập',
                ),
                const SizedBox(height: 50.0),
                const FooterLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
