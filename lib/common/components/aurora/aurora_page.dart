import 'package:flutter/material.dart';

class AuroraBackgroundPage extends StatelessWidget {
  const AuroraBackgroundPage(
      {super.key,
      required this.child,
      this.floatingActionButton,
      this.bottomNavigationBar});
  final Widget child;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          body: Stack(
            fit: StackFit.passthrough,
            children: [
              Theme.of(context).brightness == Brightness.dark
                  ? SizedBox.expand(
                      child: Image.asset(
                        "assets/images/introduction/Aurora_black.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox.expand(
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
