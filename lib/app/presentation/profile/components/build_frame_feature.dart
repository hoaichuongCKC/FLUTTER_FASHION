import 'package:flutter_fashion/app/presentation/profile/export.dart';

class BuildFrameFeature extends StatelessWidget {
  const BuildFrameFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding - 7),
      margin: const EdgeInsets.only(top: verticalPadding - 4),
      constraints: const BoxConstraints(
        maxHeight: 190.0,
        minHeight: 160,
      ),
      height: size.height * 0.3,
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(radiusBtn),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.5),
            offset: const Offset(2, 4),
            blurRadius: 10.0,
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
                      onTap: () {},
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 60,
                          minWidth: 60,
                          maxHeight: 70,
                          maxWidth: 70,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ItemFeatureProfile(model: e),
                            ),
                            Align(
                              child: Text(
                                e.label,
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
                      onTap: () => AppRoutes.push(
                          listFeatureSecond[listFeatureSecond.indexOf(e)].path),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 60,
                          minWidth: 60,
                          maxHeight: 70,
                          maxWidth: 70,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ItemFeatureProfile(model: e),
                            ),
                            Align(
                              child: Text(
                                e.label,
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
