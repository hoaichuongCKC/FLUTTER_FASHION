import 'package:flutter/material.dart';
import 'package:flutter_fashion/core/network/network_info.dart';
import 'package:flutter_fashion/dependency_injection.dart';

class ProfileBackgroundPage extends StatelessWidget {
  const ProfileBackgroundPage(
      {super.key, required this.child, this.appBar, this.floatingActionButton});
  final Widget child;

  final PreferredSizeWidget? appBar;

  final Widget? floatingActionButton;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NetWorkStatus>(
      stream: getIt<NetworkInfoImpl>().networkStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        switch (snapshot.data) {
          case NetWorkStatus.noInternet:
            return const Scaffold(body: Center(child: Text('No Internet')));

          case NetWorkStatus.successfully:
            final size = MediaQuery.of(context).size;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: appBar,
              floatingActionButton: floatingActionButton,
              body: _buildBody(size),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _buildBody(size) => Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -size.height * .1,
            left: -size.width * .65,
            child: Image.asset(
              "assets/images/half_circle.png",
            ),
          ),
          child,
        ],
      );
}
