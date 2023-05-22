import 'package:flutter_fashion/common/widgets/text_form_field_app.dart';
import 'package:flutter_fashion/export.dart';

class SetupNewPasswordCpn extends StatelessWidget {
  const SetupNewPasswordCpn({super.key});
  static final Map<String, dynamic> data = {};

  static String get password => data["password"];

  static bool get validate => data["password"] == data["confirm"];
  @override
  Widget build(BuildContext context) {
    final applocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormFieldApp(
          obscureText: true,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          hintText: "******",
          title: applocalizations.newPassword,
          prefixIcon: SvgPicture.asset(
            "assets/icons/lock.svg",
            fit: BoxFit.scaleDown,
            width: 12,
            height: 12.0,
          ),
          onChanged: (value) => data["password"] = value,
        ),
        const SizedBox(height: 10.0),
        TextFormFieldApp(
          obscureText: true,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          title: applocalizations.confirmPassword,
          hintText: applocalizations.confirmPassword,
          prefixIcon: SvgPicture.asset(
            "assets/icons/confirm_pass.svg",
            fit: BoxFit.scaleDown,
            width: 12,
            height: 12.0,
          ),
          onChanged: (value) => data["confirm"] = value,
        ),
      ],
    );
  }
}
