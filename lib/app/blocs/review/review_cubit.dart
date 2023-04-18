import 'package:bloc/bloc.dart';
import 'package:flutter_fashion/app/models/reviews/review.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_state.dart';
part 'review_cubit.freezed.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final Map<int, List<ReviewModel>> _reviewsCache = {};
  final ProductRepositoryImpl productRepo;

  ReviewCubit(this.productRepo) : super(const ReviewState.initial());

  List<ReviewModel> get getReviews => state.whenOrNull(
        success: (reviews) => reviews,
      )!;

  void fetchReview(int idProduct) async {
    if (!_reviewsCache.containsKey(idProduct)) {
      final result = await productRepo.fetchReviewProduct(1, idProduct);

      result.fold(
        (error) => emit(
          ReviewState.failure(error),
        ),
        (reviews) {
          if (reviews.isNotEmpty) {
            emit(ReviewState.success(reviews));
            _reviewsCache[idProduct] = reviews;
          }
        },
      );
    } else {
      emit(
        ReviewState.success(_reviewsCache[idProduct]!),
      );
    }
  }
}
