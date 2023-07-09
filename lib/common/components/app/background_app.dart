// ignore_for_file: must_be_immutable
import 'package:flutter_fashion/export.dart';

enum ScreenType { scroll, normal, withAppBar }

class AppBackgroundBlur extends StatelessWidget {
  final Widget child;

  final Widget? leading;

  final List<Widget>? actions;

  final List<Widget>? actionsSecond;

  final String? title;

  final Widget? bottomNavigationBar;

  final ScreenType type;

  bool? centerTitle;

  final bool isHasBackground;

  Color? backgroundAppbar;

  bool? autoLeading;

  Widget? _floatingActionButon;

  bool? resizeToAvoidBottomInset;

  bool? unfocus;

  VoidCallback? onTap;

  AppBackgroundBlur.normal({
    super.key,
    this.unfocus,
    this.leading,
    this.onTap,
    this.actions,
    this.title = "",
    required this.child,
    this.type = ScreenType.normal,
    this.bottomNavigationBar,
    Widget? floatingActionButton,
    this.actionsSecond,
    this.backgroundAppbar,
    this.isHasBackground = true,
    this.resizeToAvoidBottomInset,
  }) : _floatingActionButon = floatingActionButton;

  AppBackgroundBlur.scroll({
    super.key,
    this.leading,
    this.actions,
    this.title = "",
    this.backgroundAppbar,
    required this.child,
    this.centerTitle = true,
    this.bottomNavigationBar,
    this.type = ScreenType.scroll,
    this.actionsSecond,
    this.isHasBackground = true,
  });

  AppBackgroundBlur.withAppBar({
    super.key,
    this.leading,
    this.actions,
    this.backgroundAppbar,
    this.title = "",
    required this.child,
    this.type = ScreenType.withAppBar,
    this.bottomNavigationBar,
    Widget? floatingActionButton,
    this.actionsSecond,
    this.autoLeading = true,
    this.isHasBackground = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (type == ScreenType.normal) {
      return _buildBody(
        child: GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          child: SafeArea(
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  const SizedBox(height: 5.0),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
        size: size,
        context: context,
      );
    } else if (type == ScreenType.withAppBar) {
      return _buildBody(
        child: GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          child: SafeArea(
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
        size: size,
        context: context,
      );
    }
    return _buildBody(
      child: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                child,
              ],
            ),
          ),
        ),
      ),
      size: size,
      context: context,
    );
  }

  Widget _buildBody(
      {required Widget child,
      required Size size,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        if (unfocus != null && !unfocus!) {
          return;
        }
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        floatingActionButton: _floatingActionButon,
        bottomNavigationBar: bottomNavigationBar,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          fit: StackFit.passthrough,
          children: [
            isHasBackground
                ? BlocBuilder<SettingsCubit, SettingsState>(
                    buildWhen: (previous, current) =>
                        previous.isThemeLight != current.isThemeLight,
                    builder: (context, settings) {
                      if (!settings.isThemeLight) {
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
                  )
                : const SizedBox(),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(context) {
    if (type == ScreenType.scroll) {
      return ConstrainedBoxWidget(
        currentHeight: 0.1,
        maxHeight: 55,
        minHeight: 50,
        child: Align(
          alignment: !centerTitle! ? Alignment.centerLeft : Alignment.center,
          child: Text(
            title!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      );
    }
    if (type == ScreenType.withAppBar) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: horizontalPadding - 4),
        child: ConstrainedBoxWidget(
          currentHeight: 0.1,
          maxHeight: 50,
          minHeight: 45,
          child: ColoredBox(
            color: backgroundAppbar ??= Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                leading == null
                    ? !autoLeading!
                        ? const SizedBox()
                        : InkWell(
                            onTap: () => AppRoutes.router.pop(),
                            child: Icon(
                              Icons.arrow_back,
                              size: 24.0,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          )
                    : leading!,
                title!.isEmpty ? const SizedBox() : const SizedBox(width: 10.0),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title!,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 20.0),
                  ),
                ),
                if (actions != null)
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: actions!.map(
                          (e) {
                            final index = actions!.indexOf(e);
                            return actions![index];
                          },
                        ).toList()),
                  )
              ],
            ),
          ),
        ),
      );
    }
    return ConstrainedBoxWidget(
      currentHeight: 0.1,
      maxHeight: 85,
      minHeight: 75,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  (leading != null)
                      ? leading!
                      : InkWell(
                          onTap: () => AppRoutes.router.pop(),
                          child: Icon(
                            Icons.arrow_back,
                            size: 24.0,
                            color: Theme.of(context).iconTheme.color,
                          ),
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
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title!,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 20.0),
                    ),
                  ),
                  if (actionsSecond != null)
                    for (int i = 0; i < actionsSecond!.length; i++)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          actionsSecond![i],
                        ],
                      )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
