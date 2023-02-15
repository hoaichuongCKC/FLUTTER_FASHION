import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/presentation/profile/export.dart';

class DataBody extends StatelessWidget {
  const DataBody({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
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
              UserAvatarApp(imageUrl: user.image.url),
              const SizedBox(width: 10.0),
              const UserInformation()
            ],
          ),
        ),
        const BuildFrameFeature(),
        const OrderHistory(),
      ],
    );
  }
}
