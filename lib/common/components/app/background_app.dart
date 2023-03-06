import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fashion/app/blocs/theme/theme_cubit.dart';
import 'package:flutter_fashion/common/widgets/constrained_box.dart';
import 'package:flutter_fashion/config/constant.dart';

import '../../../routes/app_routes.dart';

enum ScreenType { titleCenter, normal }

class AppBackgroundBlur extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final Widget? bottomNavigationBar;
  final ScreenType type;

  const AppBackgroundBlur.normal({
    super.key,
    this.leading,
    this.actions,
    required this.title,
    required this.child,
    this.type = ScreenType.normal,
    this.bottomNavigationBar,
  });

  const AppBackgroundBlur.titleCenter({
    super.key,
    this.leading,
    this.actions,
    required this.title,
    required this.child,
    this.bottomNavigationBar,
    this.type = ScreenType.titleCenter,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (type == ScreenType.normal) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          bottomNavigationBar: bottomNavigationBar,
          body: Stack(
            fit: StackFit.passthrough,
            children: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  if (state.isDark) {
                    return const SizedBox();
                  }
                  return Positioned(
                    top: -size.height * .1,
                    left: -size.width * .65,
                    child: Image.asset(
                      "assets/images/half_circle.png",
                    ),
                  );
                },
              ),
              SafeArea(
                child: SizedBox.expand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAppBar(context),
                      const SizedBox(height: 15.0),
                      child,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.passthrough,
          children: [
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                if (state.isDark) {
                  return const SizedBox();
                }
                return Positioned(
                  top: -size.height * .1,
                  left: -size.width * .65,
                  child: Image.asset(
                    "assets/images/half_circle.png",
                  ),
                );
              },
            ),
            SafeArea(
              child: SizedBox.expand(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding - 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAppBar(context),
                      const SizedBox(height: 15.0),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(context) {
    if (type == ScreenType.titleCenter) {
      return ConstrainedBoxWidget(
        currentHeight: 0.1,
        maxHeight: 60,
        minHeight: 50,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      );
    }
    return ConstrainedBoxWidget(
      currentHeight: 0.1,
      maxHeight: 100,
      minHeight: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  (leading != null)
                      ? leading!
                      : InkWell(
                          onTap: () => AppRoutes.pop(),
                          child: Icon(Icons.arrow_back,
                              size: 30.0,
                              color: Theme.of(context).iconTheme.color),
                        ),
                  if (actions != null)
                    for (int i = 0; i < actions!.length; i++)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          actions![i],
                        ],
                      )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            )
          ],
        ),
      ),
    );
  }
}
