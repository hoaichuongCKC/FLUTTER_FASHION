import 'package:flutter_fashion/app/presentation/change_password/components/textfield_change_pass.dart';
import 'package:flutter_fashion/export.dart';

class SetupNewPasswordCpn extends StatelessWidget {
  const SetupNewPasswordCpn({super.key});
  static final Map<String, dynamic> data = {};

  static String get password => data["password"];

  static bool get validate => data["password"] == data["confirm"];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppLocalizations.of(context)!.newPassword}(*)",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFieldChangePasswordWidget(
          iconUrl: "assets/icons/lock.svg",
          hintText: AppLocalizations.of(context)!.newPassword,
          key: const ValueKey("change_form_new_pasword"),
          onChanged: (value) => data["password"] = value,
        ),
        const SizedBox(height: 15.0),
        Text(
          "${AppLocalizations.of(context)!.confirmPassword}(*)",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFieldChangePasswordWidget(
          iconUrl: "assets/icons/confirm_pass.svg",
          hintText: AppLocalizations.of(context)!.confirmPassword,
          key: const ValueKey("change_form_confirm_pasword"),
          onChanged: (value) => data["confirm"] = value,
        ),
      ],
    );
  }
}
