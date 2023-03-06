part of 'banner_cubit.dart';

@freezed
class BannerState with _$BannerState {
  const factory BannerState.initial() = _Initial;
  const factory BannerState.loading() = _Loading;
  const factory BannerState.fetchCompleted(List<SliderModel> banner) =
      _FetchCompleted;
  const factory BannerState.error(String error) = _Error;
}
