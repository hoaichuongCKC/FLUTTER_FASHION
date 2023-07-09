import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/filling_out_information_personal.dart';
import 'package:flutter_fashion/app/presentation/sign_up/widgets/choose_image_widget.dart';
import 'package:flutter_fashion/common/widgets/text_form_field_app.dart';

class SetupPasswordAvatarCpn extends StatelessWidget {
  const SetupPasswordAvatarCpn({super.key});

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;
    return Column(
      children: [
        ChooseImageWidget(
          onTap: (file) {
            FillingOutInformationPersonalCpn.data["avatar"] = file;
          },
        ),
        const SizedBox(height: 10.0),
        TextFormFieldApp(
          title: applocalization.password,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          hintText: applocalization.enter_the(applocalization.password),
          onChanged: (p0) =>
              FillingOutInformationPersonalCpn.data["password"] = p0,
        ),
        const SizedBox(height: 10.0),
        TextFormFieldApp(
          title: applocalization.confirmPassword,
          textInputAction: TextInputAction.done,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          hintText: applocalization.confirmPassword,
          onChanged: (p0) =>
              FillingOutInformationPersonalCpn.data["confirm"] = p0,
        ),
      ],
    );
  }
}
