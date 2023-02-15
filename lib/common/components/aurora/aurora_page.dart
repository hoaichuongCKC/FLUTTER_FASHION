import 'package:flutter/material.dart';

class AuroraBackgroundPage extends StatelessWidget {
  const AuroraBackgroundPage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/introduction/Aurora.png",
                fit: BoxFit.cover,
              ),
              child,
            ],
          ),
        ),
      );
}
