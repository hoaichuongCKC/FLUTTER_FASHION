import 'package:flutter_fashion/app/presentation/profile/export.dart';
import 'package:flutter_fashion/app/presentation/profile/profile_data.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ProfileData.of(context)!.user;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100.0,
            minHeight: 80,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserAvatarApp(imageUrl: user.photo),
              const SizedBox(width: 10.0),
              const UserInformation()
            ],
          ),
        ),
        const BuildFrameFeature(),
        const SizedBox(height: 30),
        ButtonWidget(
          height: MediaQuery.of(context).size.height * .06,
          btnColor: primaryColor,
          onPressed: () => showDialogNotiLogout(context),
          label: AppLocalizations.of(context)!.logout,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

showDialogNotiLogout(BuildContext context) {
  popupAlert(
    context: context,
    message: AppLocalizations.of(context)!.are_you_sure_to_log_out,
    onCancel: () => AppRoutes.router.pop(),
    onPressed: () {
      AppRoutes.router.pop();
      loadingAlert(context: context);
      context.read<AuthCubit>().call(AuthEvent.loggout, context: context);
    },
  );
}
