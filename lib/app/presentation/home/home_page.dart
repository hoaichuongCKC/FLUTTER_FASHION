import 'package:flutter_fashion/app/presentation/login/export.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Text(AppLocalizations.of(context)!.homePage),
            ),
          ],
        ),
      ),
    );
  }
}
