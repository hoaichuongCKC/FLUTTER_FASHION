import 'package:flutter_fashion/app/presentation/profile/export.dart';
import 'package:flutter_fashion/app/presentation/profile/profile_data.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ProfileData.of(context)!.user;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            user.username,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            user.phone,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
