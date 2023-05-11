import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/presentation/profile/export.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = InheritedDataApp.of<UserModel>(context)!.data;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            UserAvatarApp(imageUrl: user.photo),
            const SizedBox(width: 10.0),
            const UserInformation()
          ],
        ),
        const BuildFrameFeature(),
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
