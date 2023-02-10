import 'package:flutter/material.dart';

class AuroraBackgroundPage extends StatelessWidget {
  const AuroraBackgroundPage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/introduction/Aurora.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: child,
          ),
        ),
      );
}
