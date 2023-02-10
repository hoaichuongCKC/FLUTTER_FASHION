import 'package:flutter_fashion/app/presentation/login/export.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  GlobalKey<FormState> get _formKey => widget.formKey;

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: phoneController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: lightColor,
              hintText: 'Số điện thoại',
              //contentPadding: const EdgeInsets.symmetric(vertical: horizontalPadding),
              prefixIconConstraints: const BoxConstraints(
                minHeight: 20.0,
                maxHeight: 50.0,
                minWidth: 20.0,
                maxWidth: 50.0,
              ),
              isDense: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SvgPicture.asset(
                  "assets/icons/phone.svg",
                  fit: BoxFit.contain,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              hintStyle: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: disableDarkColor,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Không được để trống";
              }
              return null;
            },
          ),
          const SizedBox(height: 15.0),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              filled: true,
              fillColor: lightColor,
              hintText: 'Mật khẩu',
              isDense: true,
              suffixIconConstraints: const BoxConstraints(
                minHeight: 20.0,
                maxHeight: 50.0,
                minWidth: 20.0,
                maxWidth: 50.0,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SvgPicture.asset(
                  "assets/icons/eye.svg",
                  fit: BoxFit.contain,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minHeight: 20.0,
                maxHeight: 50.0,
                minWidth: 20.0,
                maxWidth: 50.0,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: SvgPicture.asset(
                  "assets/icons/lock.svg",
                  fit: BoxFit.contain,
                  width: 40.0,
                  height: 40.0,
                ),
              ),
              hintStyle: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: disableDarkColor,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Không được để trống";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
