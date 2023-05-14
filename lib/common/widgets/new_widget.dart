import 'package:flutter_fashion/export.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      color: errorColor,
      alignment: Alignment.center,
      child: Text(
        "New",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 7.0,
              color: lightColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
