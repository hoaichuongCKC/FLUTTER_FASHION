import 'package:flutter_fashion/app/presentation/profile/export.dart';

class BuildFrameFeature extends StatelessWidget {
  const BuildFrameFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLight = Brightness.light == Theme.of(context).brightness;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding - 7),
      margin: const EdgeInsets.only(top: verticalPadding - 4),
      constraints: const BoxConstraints(
        maxHeight: 160.0,
        minHeight: 140.0,
      ),
      height: size.height * 0.3,
      decoration: BoxDecoration(
        color: isLight ? lightColor : lightColor.withOpacity(0.9),
        borderRadius: const BorderRadius.all(
          Radius.circular(radiusBtn),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.5),
            offset: const Offset(0.5, 2),
            blurRadius: 3.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: listFeatureFirst
                  .map(
                    (e) => InkWell(
                      onTap: () => AppRoutes.router.pushNamed(
                          listFeatureFirst[listFeatureFirst.indexOf(e)].path),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                          minWidth: 50,
                          maxHeight: 60,
                          maxWidth: 60,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ItemFeatureProfile(model: e),
                            ),
                            Align(
                              child: Text(
                                e.path.translateLabelFeatureProfile(context),
                                style: PrimaryFont.instance.copyWith(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: listFeatureSecond
                  .map(
                    (e) => InkWell(
                      onTap: () => AppRoutes.router.pushNamed(
                          listFeatureSecond[listFeatureSecond.indexOf(e)].path),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 50,
                          minWidth: 50,
                          maxHeight: 60,
                          maxWidth: 60,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ItemFeatureProfile(model: e),
                            ),
                            Align(
                              child: Text(
                                e.path.translateLabelFeatureProfile(context),
                                style: PrimaryFont.instance.copyWith(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
