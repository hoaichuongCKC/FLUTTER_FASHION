import 'package:flutter_fashion/app/blocs/create_review/create_review_cubit.dart';
import 'package:flutter_fashion/app/presentation/create_review/components/list_image.dart';
import 'package:flutter_fashion/app/presentation/create_review/components/list_star.dart';
import '../../../common/components/app/background_app.dart';
import '../../../export.dart';

class CreateReviewPage extends StatelessWidget {
  const CreateReviewPage({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => getIt<CreateReviewCubit>()..changedOrderId(orderId),
      child: AppBackgroundBlur.normal(
        isHasBackground: false,
        title: AppLocalizations.of(context)!.product_rating,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: horizontalPadding - 4,
              horizontal: horizontalPadding - 4),
          child: Builder(builder: (context) {
            return ButtonWidget(
              btnColor: primaryColor,
              onPressed: () =>
                  context.read<CreateReviewCubit>().rating(context, orderId),
              height: 45.0,
              animate: true,
              label: AppLocalizations.of(context)!.rate_now,
            );
          }),
        ),
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListStarCpn(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: ListImageRating(),
                ),
                TextFormField(
                  maxLines: 5,
                  style: Theme.of(context).textTheme.bodySmall,
                  onChanged: (value) =>
                      context.read<CreateReviewCubit>().changedContent(value),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.write_something,
                    hintStyle: theme.inputDecorationTheme.hintStyle!,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 10.0),
                    enabledBorder: theme.inputDecorationTheme.border!.copyWith(
                      borderSide: const BorderSide(color: primaryColor),
                    ),
                    border: theme.inputDecorationTheme.border!.copyWith(
                      borderSide: const BorderSide(color: primaryColor),
                    ),
                    focusedBorder: theme.inputDecorationTheme.border!.copyWith(
                      borderSide: const BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
