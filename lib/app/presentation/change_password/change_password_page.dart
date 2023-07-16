import 'package:flutter_fashion/app/blocs/change_password/change_password_cubit.dart';
import 'package:flutter_fashion/app/presentation/modules/user/personal_information/export.dart';
import 'package:flutter_fashion/common/widgets/text_form_field_app.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<ChangePasswordCubit>(),
      child: Builder(builder: (context) {
        final bloc = context.read<ChangePasswordCubit>();
        return AppBackgroundBlur.normal(
          unfocus: false,
          title: AppLocalizations.of(context)!.changePassword,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding - 4, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormFieldApp(
                  obscureText: true,
                  title: applocalization.currentPassword,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "******",
                  prefixIcon: SvgPicture.asset(
                    Assets.lockSVG,
                    fit: BoxFit.scaleDown,
                    width: 12,
                    height: 12.0,
                  ),
                  onChanged: (value) => bloc.onChangedCurrentPassword(value),
                ),
                const SizedBox(height: 10.0),
                TextFormFieldApp(
                  obscureText: true,
                  title: applocalization.newPassword,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "******",
                  prefixIcon: SvgPicture.asset(
                    Assets.lockSVG,
                    fit: BoxFit.scaleDown,
                    width: 12,
                    height: 12.0,
                  ),
                  onChanged: (value) => bloc.onChangedNewPassword(value),
                ),
                const SizedBox(height: 10.0),
                TextFormFieldApp(
                  obscureText: true,
                  title: applocalization.confirmPassword,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "******",
                  prefixIcon: SvgPicture.asset(
                    Assets.lockSVG,
                    fit: BoxFit.scaleDown,
                    width: 12,
                    height: 12.0,
                  ),
                  onChanged: (value) => bloc.onChangedConfirmPassword(value),
                ),
                const Spacer(),
                ButtonWidget(
                  height: 45.0,
                  onPressed: () {
                    bloc.submitForm(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.update,
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
                      color: lightColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
