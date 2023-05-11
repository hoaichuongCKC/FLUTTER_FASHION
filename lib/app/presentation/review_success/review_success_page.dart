import 'package:flutter_fashion/app/presentation/personal_information/export.dart';

import 'package:lottie/lottie.dart';

class ReviewSuccessPage extends StatelessWidget {
  const ReviewSuccessPage({super.key, required this.indexParam});
  final int indexParam;

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      isHasBackground: false,
      leading: InkWell(
        onTap: () => AppRoutes.router.go(Routes.PROFILE),
        child: const Icon(
          Icons.clear,
          size: 24.0,
        ),
      ),
      title: AppLocalizations.of(context)!.feedback,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Lottie.asset(
                  "assets/json/order-success.json",
                  repeat: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    5,
                    (index) => SvgPicture.asset("assets/icons/star.svg",
                        width: 30,
                        height: 30.0,
                        colorFilter: indexParam + 1 <= index
                            ? ColorFilter.mode(
                                darkColor.withOpacity(0.2), BlendMode.srcIn)
                            : const ColorFilter.mode(
                                Colors.yellow, BlendMode.srcIn)),
                  ).toList(),
                ),
              ),
              Text(
                AppLocalizations.of(context)!
                    .thanks_your_feedback_it_is_will_helps_us_improve_our_product,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
