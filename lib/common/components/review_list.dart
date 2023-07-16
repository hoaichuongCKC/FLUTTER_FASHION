import 'package:flutter_fashion/app/models/reviews/review.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';

class ReviewListCpn extends StatelessWidget {
  const ReviewListCpn(
      {super.key, required this.reviews, this.shrinkWrap = true});
  final List<ReviewModel> reviews;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: reviews.length,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemBuilder: (context, index) {
        final review = reviews[index];

        final checkImages = review.photos.isEmpty || review.photos.isEmpty;

        Widget imageWidget = const SizedBox();

        final Widget contentWidget = Text(
          review.content,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        );

        if (!checkImages) {
          imageWidget = Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: LimitedBox(
              maxHeight: 70.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: review.photos
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(radiusBtn)),
                            child: CachedNetworkImage(
                              imageUrl: ApiService.imageUrl + item,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: review.user.photo.isEmpty
                  ? CircleAvatar(
                      backgroundColor: lightColor,
                      child: SvgPicture.asset(
                        Assets.userSVG,
                        fit: BoxFit.contain,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        ApiService.imageUrl + review.user.photo,
                      ),
                    ),
              title: Text(
                review.user.fullName,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Text(
                review.updated_at.viewDate(context),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    review.star.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SvgPicture.asset(
                    "assets/icons/star.svg",
                    colorFilter: ColorFilter.mode(
                      starColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            imageWidget,
            contentWidget,
          ],
        );
      },
    );
  }
}
