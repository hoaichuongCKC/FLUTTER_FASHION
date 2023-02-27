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
          user.phone.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.4),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: InkWell(
                      onTap: () => AppRoutes.push(Routes.PERSONAL),
                      child: SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Vui lòng cập nhật thông tin",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 14.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Text(
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
