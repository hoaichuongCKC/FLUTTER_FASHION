import 'package:flutter_fashion/app/models/reviews/review.dart';
import 'package:flutter_fashion/app/presentation/product_detail/blocs/review_bloc.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';
import '../../../../export.dart';

class ReviewDetail extends StatelessWidget {
  const ReviewDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductDetailInherited.of(context);
    final reviewBloc = getIt<ReviewBLoc>();

    if (product.productModel.star == null || product.productModel.star == 0.0) {
      return Text(
        "Hiện chưa có đánh giá nào cho sản phẩm này",
        style: PrimaryFont.instance.large(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Đánh giá",
          style: PrimaryFont.instance.large(),
        ),
        StreamBuilder<List<ReviewModel>>(
          stream: reviewBloc.listReviewStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            final data = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (context, index) => (index == data.length - 1)
                  ? const SizedBox()
                  : Divider(color: disableDarkColor.withOpacity(0.1)),
              itemCount: data.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ItemReview(review: data[index]);
              },
            );
          },
        ),
        StreamBuilder<bool>(
          stream: reviewBloc.loadMoreStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || !snapshot.data!) {
              return const SizedBox();
            }
            return TextButton(
              onPressed: () => getIt<ReviewBLoc>().fetchLoadMore(),
              child: Text(
                "Hiển tất cả",
                style: PrimaryFont.instance.copyWith(
                  fontSize: 14.0,
                  color: darkColor.withOpacity(0.5),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 45.0),
      ],
    );
  }
}

class ItemReview extends StatelessWidget {
  const ItemReview({
    super.key,
    required this.review,
  });
  final ReviewModel review;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            review.user.username,
            style: PrimaryFont.instance.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                review.star.toString(),
                style: PrimaryFont.instance.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SvgPicture.asset("assets/icons/star.svg"),
            ],
          ),
          subtitle: Text(review.created_at!.formatDateTime()),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              ApiService.imageUrl + review.user.photo,
              cacheKey: review.user.photo,
              headers: getIt<ApiService>().headers,
            ),
          ),
        ),
        review.images!.isEmpty ? const SizedBox() : const SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            review.images!.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: 60.0,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: review.images!.map(
                          (e) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: CachedNetworkImage(
                                  imageUrl: ApiService.imageUrl + e.photo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ).toList()),
                  ),
            const SizedBox(height: 8.0),
            Text(
              review.content!,
              style: PrimaryFont.instance.copyWith(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        )
      ],
    );
  }
}
