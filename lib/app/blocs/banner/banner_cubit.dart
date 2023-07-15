
import 'package:flutter_fashion/app/repositories/banner_repository.dart';
import 'package:flutter_fashion/core/handler/error_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../export.dart';

part 'banner_state.dart';
part 'banner_cubit.freezed.dart';

class BannerCubit extends Cubit<BannerState>
    with HandlerErrorCubit<BannerState> {
  final BannerRepositoryImpl _bannerRepositoryImpl;
  BannerCubit({required BannerRepositoryImpl bannerRepositoryImpl})
      : _bannerRepositoryImpl = bannerRepositoryImpl,
        super(const BannerState.initial());
  bool _isFirstLoad = false;
  void fetchData(BuildContext context) async {
    if (!isClosed && !_isFirstLoad) {
      emit(const BannerState.loading());

      final result = await _bannerRepositoryImpl.fetchBanner();

      result.fold(
        (error) {
          handlerError(context, error, BannerState.error(error));
        },
        (list) {
          emit(BannerState.fetchCompleted(list));
          _isFirstLoad = true;
        },
      );
    }
  }

  void onRefresh(context) async {
    _isFirstLoad = false;
    fetchData(context);
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
