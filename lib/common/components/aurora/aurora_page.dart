import 'package:flutter/material.dart';

class AuroraBackgroundPage extends StatelessWidget {
  const AuroraBackgroundPage(
      {super.key, required this.child, this.bottomNavigatorBar});
  final Widget child;
  final Widget? bottomNavigatorBar;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          bottomNavigationBar: bottomNavigatorBar,
          body: Stack(
            fit: StackFit.passthrough,
            children: [
              SizedBox.expand(
                child: Image.asset(
                  "assets/images/introduction/Aurora.png",
                  fit: BoxFit.cover,
                ),
              ),
              child,
            ],
          ),
        ),
      );
}
