import 'package:flutter_fashion/app/blocs/change_password/change_password_cubit.dart';
import 'package:flutter_fashion/app/presentation/change_password/components/textfield_change_pass.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordCubit>(),
      child: Builder(builder: (context) {
        final bloc = context.read<ChangePasswordCubit>();
        return AppBackgroundBlur.normal(
          title: AppLocalizations.of(context)!.changePassword,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ButtonWidget(
              height: 45.0,
              btnColor: primaryColor,
              onPressed: () {
                if (!validateChangePassword) return;
                bloc.submitForm(context);
              },
              radius: radiusBtn,
              label: AppLocalizations.of(context)!.update,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding - 4, vertical: verticalPadding),
            child: Form(
              key: formkeyChangePassword,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldChangePasswordWidget(
                    iconUrl: "assets/icons/lock.svg",
                    hintText: AppLocalizations.of(context)!.currentPassword,
                    key: const ValueKey("change_form_current_pasword"),
                    onChanged: (value) => bloc.onChangedCurrentPassword(value),
                  ),
                  const SizedBox(height: 10.0),
                  TextFieldChangePasswordWidget(
                    iconUrl: "assets/icons/lock.svg",
                    hintText: AppLocalizations.of(context)!.newPassword,
                    key: const ValueKey("change_form_new_pasword"),
                    onChanged: (value) => bloc.onChangedNewPassword(value),
                  ),
                  const SizedBox(height: 10.0),
                  TextFieldChangePasswordWidget(
                    iconUrl: "assets/icons/confirm_pass.svg",
                    hintText: AppLocalizations.of(context)!.confirmPassword,
                    key: const ValueKey("change_form_confirm_pasword"),
                    onChanged: (value) => bloc.onChangedConfirmPassword(value),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
