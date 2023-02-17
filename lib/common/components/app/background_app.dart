import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fashion/app/blocs/theme/theme_cubit.dart';
import 'package:flutter_fashion/common/widgets/constrained_box.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:flutter_fashion/config/constant.dart';
import 'package:flutter_fashion/config/font_style.dart';
import 'package:flutter_fashion/routes/app_routes.dart';

class BaseAppBackground extends StatelessWidget {
  const BaseAppBackground({
    super.key,
    required this.child,
    this.leading,
    this.actions,
    required this.title,
  });
  final Widget child;
  final Widget? leading;
  final List<Widget>? actions;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      fit: StackFit.passthrough,
      children: [
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            if (!state.isLight) {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAppBar(context),
                const SizedBox(height: 5.0),
                child,
              ],
            ),
          ),
        ),
      ],
    ));
  }

  ConstrainedBoxWidget _buildAppBar(context) {
    return ConstrainedBoxWidget(
      currentHeight: 0.1,
      maxHeight: 120,
      minHeight: 100,
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
    );
  }
}
