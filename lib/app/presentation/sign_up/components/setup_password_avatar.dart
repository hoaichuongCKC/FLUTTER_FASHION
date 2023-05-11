import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/presentation/sign_up/components/filling_out_information_personal.dart';
import 'package:flutter_fashion/app/presentation/sign_up/widgets/choose_image_widget.dart';
import 'package:flutter_fashion/app/presentation/sign_up/widgets/text_form_field_widget.dart';

class SetupPasswordAvatarCpn extends StatelessWidget {
  const SetupPasswordAvatarCpn({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ChooseImageWidget(
          onTap: (file) {
            FillingOutInformationPersonalCpn.data["avatar"] = file;
          },
        ),
        const SizedBox(height: 15.0),
        TextFormFieldRegister(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          hintText: AppLocalizations.of(context)!
              .enter_the(AppLocalizations.of(context)!.password)
              .toBeginningOfSentenceCase(),
          labelText: Text(
            "${AppLocalizations.of(context)!.password}(*)",
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          isobscureText: true,
          prefixIcon: SvgPicture.asset(
            "assets/icons/lock.svg",
            fit: BoxFit.scaleDown,
          ),
          onChanged: (value) =>
              FillingOutInformationPersonalCpn.data["password"] = value,
        ),
        const SizedBox(height: 15.0),
        TextFormFieldRegister(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
          hintText: AppLocalizations.of(context)!
              .enter_the(AppLocalizations.of(context)!.confirmPassword)
              .toBeginningOfSentenceCase(),
          labelText: Text(
            "${AppLocalizations.of(context)!.confirmPassword}(*)",
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          isobscureText: true,
          prefixIcon: SvgPicture.asset(
            "assets/icons/lock.svg",
            fit: BoxFit.scaleDown,
          ),
          onChanged: (value) =>
              FillingOutInformationPersonalCpn.data["confirm"] = value,
        ),
      ],
    );
  }
}
