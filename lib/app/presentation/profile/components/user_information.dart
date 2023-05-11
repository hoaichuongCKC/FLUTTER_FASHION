import 'package:flutter_fashion/app/presentation/personal_information/export.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    final user = InheritedDataApp.of<UserModel>(context)!.data;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            user.username,
            style: Theme.of(context).textTheme.bodyMedium,
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
                      onTap: () => AppRoutes.router.push(Routes.PERSONAL),
                      child: SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .please_update_information,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 12.0,
                                    color: isLight
                                        ? darkColor
                                        : lightColor.withOpacity(0.75),
                                  ),
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
                      .bodySmall!
                      .copyWith(fontSize: 12.0),
                ),
        ],
      ),
    );
  }
}
