import 'package:flutter_fashion/app/models/slider/slider.dart';
import 'package:flutter_fashion/app/repositories/banner_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../export.dart';

part 'banner_state.dart';
part 'banner_cubit.freezed.dart';

class BannerCubit extends Cubit<BannerState> {
  final BannerRepositoryImpl _bannerRepositoryImpl;
  BannerCubit({required BannerRepositoryImpl bannerRepositoryImpl})
      : _bannerRepositoryImpl = bannerRepositoryImpl,
        super(const BannerState.initial());
  bool _isFirstLoad = false;
  void fetchData() async {
    if (!isClosed && !_isFirstLoad) {
      emit(const BannerState.loading());

      final result = await _bannerRepositoryImpl.fetchBanner();

      result.fold(
        (error) {
          if (error == AuthenticatedException.message) {
            HydratedBloc.storage.delete(KeyStorage.token);
            AppRoutes.router.go(Routes.LOGIN);
          }
          emit(BannerState.error(error));
        },
        (list) {
          emit(BannerState.fetchCompleted(list));
          _isFirstLoad = true;
        },
      );
    }
  }

  void onRefresh() async {
    emit(const BannerState.loading());
    final result = await _bannerRepositoryImpl.fetchBanner();

    result.fold(
      (error) => emit(BannerState.error(error)),
      (list) {
        emit(BannerState.fetchCompleted(list));
        _isFirstLoad = true;
      },
    );
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
