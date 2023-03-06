import 'package:flutter_fashion/app/presentation/profile/export.dart';
import 'package:flutter_fashion/app/presentation/profile/profile_data.dart';

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
        const OrderHistory(),
        const SizedBox(height: 30),
      ],
    );
  }
}
