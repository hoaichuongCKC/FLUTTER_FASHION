import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
