import 'package:flutter_fashion/app/presentation/sign_up/sign_up_page.dart';
import 'package:flutter_fashion/common/widgets/text_form_field_app.dart';
import 'package:flutter_fashion/core/base/params/register.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/svg_files.dart';
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

  static String get password => data["password"] ?? "";

  static String get confirm => data["confirm"] ?? "";

  static XFile? get image => data["avatar"];

  static String get email => data["email"];


  @override
  Widget build(BuildContext context) {
    data["phone"] = SignUpPage.phoneNumber;

    final applocalization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormFieldApp(
          title: applocalization.fullname,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          prefixIcon: SvgPicture.asset(
            Assets.userSVG,
            fit: BoxFit.scaleDown,
            width: 12,
            height: 12.0,
            colorFilter: const ColorFilter.mode(
              darkColor,
              BlendMode.srcIn,
            ),
          ),
          hintText: applocalization.enter_the(applocalization.fullname),
          onChanged: (p0) => data["fullname"] = p0,
        ),
        const SizedBox(height: 10.0),
        TextFormFieldApp(
          readOnly: true,
          title:
              "${applocalization.phoneNumber} (${AppLocalizations.of(context)!.readonly})",
          hintText: data["phone"],
          onChanged: (p0) => data["phone"] = p0,
          prefixIcon: const Icon(
            Icons.phone,
            size: 12.0,
            color: darkColor,
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormFieldApp(
          title: "Email",
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          hintText: applocalization.enter_the("email"),
          onChanged: (p0) => data["email"] = p0,
          prefixIcon: const Icon(
            Icons.email,
            size: 12.0,
            color: darkColor,
          ),
        ),
      ],
    );
  }
}
