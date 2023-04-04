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
    // final order =
    //     context.watch<OrderCubit>().state.deliveredList[int.parse(index)];
    return BlocProvider(
      create: (context) => getIt<CreateReviewCubit>()..changedOrderId(orderId),
      child: AppBackgroundBlur.normal(
        isHasBackground: false,
        title: AppLocalizations.of(context)!.product_rating,
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListStar(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextFormField(
                    maxLines: 5,
                    onChanged: (value) =>
                        context.read<CreateReviewCubit>().changedContent(value),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.write_something,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 10.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(radiusBtn),
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(radiusBtn),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(radiusBtn),
                        ),
                      ),
                    ),
                  ),
                ),
                const ListImageRating(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ButtonWidget(
                    btnColor: primaryColor,
                    onPressed: () => context
                        .read<CreateReviewCubit>()
                        .rating(context, orderId),
                    height: 45.0,
                    animate: true,
                    label: AppLocalizations.of(context)!.rate_now,
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
