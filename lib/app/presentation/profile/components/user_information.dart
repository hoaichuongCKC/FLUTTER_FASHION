import 'package:flutter_fashion/app/presentation/profile/export.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 2,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.7,
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  'JackTheRipper',
                  style: PrimaryFont.instance
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.45,
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  '0918031587',
                  style: PrimaryFont.instance
                      .copyWith(fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
