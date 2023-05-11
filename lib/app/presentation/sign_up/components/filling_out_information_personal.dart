import 'package:flutter_fashion/app/presentation/sign_up/sign_up_page.dart';
import 'package:flutter_fashion/app/presentation/sign_up/widgets/text_form_field_widget.dart';
import 'package:flutter_fashion/core/base/params/register.dart';

import '../../../../export.dart';

class FillingOutInformationPersonalCpn extends StatelessWidget {
  const FillingOutInformationPersonalCpn({super.key});
  static final Map<String, dynamic> data = {};
  static RegisterParams get params => RegisterParams(
        fullname: data["fullname"],
        phone: data["phone"],
        email: data["email"],
        password: data["password"],
        image: data["avatar"],
      );
  static bool get checkMatchPassword => data["password"] == data["confirm"];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    data["phone"] = SignUpPage.phoneNumber;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormFieldRegister(
          onChanged: (p0) => data["fullname"] = p0,
          keyboardType: TextInputType.name,
          hintText: AppLocalizations.of(context)!
              .enter_the(AppLocalizations.of(context)!.fullname)
              .toBeginningOfSentenceCase(),
          labelText: Text(
            "${AppLocalizations.of(context)!.fullname}(*)",
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          prefixIcon: SvgPicture.asset(
            "assets/icons/user_outline.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
        const SizedBox(height: 15.0),
        TextFormFieldRegister(
          readOnly: true,
          keyboardType: TextInputType.phone,
          hintText: SignUpPage.phoneNumber,
          prefixIcon: SvgPicture.asset(
            "assets/icons/phone.svg",
            fit: BoxFit.scaleDown,
          ),
          labelText: Text(
            "${AppLocalizations.of(context)!.phoneNumber}(*)",
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        TextFormFieldRegister(
          keyboardType: TextInputType.emailAddress,
          hintText: AppLocalizations.of(context)!.enter_the("email"),
          labelText: Text(
            'Email(*)',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          prefixIcon: SvgPicture.asset(
            "assets/icons/email.svg",
            fit: BoxFit.scaleDown,
          ),
          onChanged: (p0) => data["email"] = p0,
          validator: (p0) {
            if (p0!.isEmpty) {
              return "Do not empty";
            }
            if (!p0.isValidEmail()) {
              return "Invalid email";
            }
            return null;
          },
        ),
      ],
    );
  }
}
