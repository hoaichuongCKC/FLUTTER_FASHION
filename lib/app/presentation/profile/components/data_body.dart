import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/presentation/profile/export.dart';

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
