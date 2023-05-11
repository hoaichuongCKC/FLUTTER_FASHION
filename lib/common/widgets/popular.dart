import 'package:flutter_fashion/app/presentation/login/export.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBadge();
  }

  Widget buildBadge() => Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        color: Colors.teal,
        child: Text(
          'POPULAR',
          style: PrimaryFont.instance.copyWith(
            fontSize: 7.0,
            color: lightColor,
          ),
        ),
      );
}
