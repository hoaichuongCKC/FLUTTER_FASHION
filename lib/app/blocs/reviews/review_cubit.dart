import 'package:flutter_fashion/app/models/review_chart/review_chart_model.dart';
import 'package:flutter_fashion/app/models/star/star_model.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_state.dart';
part 'review_cubit.freezed.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final Map<int, ReviewsModel> _reviewsCache = {};
  final Map<int, Map<String, dynamic>> _loadmoreCache = {};
  final ProductRepositoryImpl productRepo;

  ReviewCubit(this.productRepo) : super(const ReviewState.initial());

  ReviewsModel get getReviews => state.whenOrNull(
        success: (reviews) => reviews,
      )!;

  int get getLength => state.whenOrNull(
        success: (reviews) => reviews.length,
      )!;

  List<StarModel> get getstarGroup => state.whenOrNull(
        success: (reviews) => reviews.star_group,
      )!;

  void _saveLoadmoreCache(int idProduct) {
    if (!_loadmoreCache.containsKey(idProduct)) {
      _loadmoreCache.putIfAbsent(idProduct, () => {});
    }
    final page = _loadmoreCache[idProduct]?["page"] ??= 1;
    if (page >= 1) {
      _loadmoreCache[idProduct]?["page"]++;
    }
    _loadmoreCache[idProduct]?["loadmore"] = true;
  }

  void fetchData(int idProduct, ProductDetailUiCubit bloc) async {
    if (!_reviewsCache.containsKey(idProduct)) {
      final result = await productRepo.fetchReviewProduct(1, idProduct);

      result.fold(
        (error) => emit(ReviewState.failure(error)),
        (reviews) {
          if (reviews.reviews.isEmpty) {
            emit(ReviewState.success(reviews));

            bloc.changeHasLoadmore(false);

            _loadmoreCache[idProduct]?["loadmore"] = false;

            return;
          }

          final starGroupNew = List<StarModel>.from(reviews.star_group!)
            ..sort((a, b) => b.star.compareTo(a.star));

          reviews = reviews.copyWith(star_group: starGroupNew);

          emit(ReviewState.success(reviews));

          _saveLoadmoreCache(idProduct);

          _reviewsCache[idProduct] = reviews;
        },
      );
    } else {
      emit(ReviewState.success(_reviewsCache[idProduct]!));

      bloc.changeHasLoadmore(_loadmoreCache[idProduct]!["loadmore"]);
    }
  }

  void loadMore(int idProduct, context) async {
    if (!_loadmoreCache[idProduct]?["loadmore"]) return;

    final result = await productRepo.fetchReviewProduct(
        _loadmoreCache[idProduct]?["page"], idProduct);

    result.fold(
      (error) => emit(ReviewState.failure(error)),
      (reviews) {
        if (reviews.reviews.isEmpty) {
          BlocProvider.of<ProductDetailUiCubit>(context)
              .changeHasLoadmore(false);

          _loadmoreCache[idProduct]?["loadmore"] = false;
          return;
        }
        final newListReview = [...getReviews.reviews, ...reviews.reviews];

        emit(ReviewState.success(getReviews.copyWith(
          reviews: newListReview,
          star_group: getstarGroup,
          length: getLength,
        )));

        _saveLoadmoreCache(idProduct);

        _reviewsCache[idProduct] = getReviews;
      },
    );
  }

  void onRefresh(int idProduct, ProductDetailUiCubit bloc) {
    print('danh sách review với idProduct: $idProduct');

    _reviewsCache.remove(idProduct);
    print('My list: ${_reviewsCache.containsKey(idProduct)}');

    fetchData(idProduct, bloc);
  }
}
