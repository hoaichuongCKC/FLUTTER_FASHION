import 'package:flutter_fashion/app/models/slider/slider.dart';
import 'package:flutter_fashion/app/repositories/banner_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/pusher/beams.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
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
  void fetchData(BuildContext context) async {
    if (!isClosed && !_isFirstLoad) {
      emit(const BannerState.loading());

      final result = await _bannerRepositoryImpl.fetchBanner();

      result.fold(
        (error) {
          if (error != AuthenticatedException.message) {
            emit(BannerState.error(error));
          } else {
            popupAlert(
              context: context,
              noButtonCancle: true,
              message: AppLocalizations.of(context)!.login_session_has_expired,
              onPressed: () {
                PusherBeamsApp.instance.dispose();
                HydratedBloc.storage.delete(KeyStorage.token);
                AppRoutes.router.pop();
                AppRoutes.router.go(Routes.LOGIN);
              },
            );
          }
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
