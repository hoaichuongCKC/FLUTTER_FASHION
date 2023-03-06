import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/models/slider/slider.dart';
import 'package:flutter_fashion/app/network_provider/banner_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';

abstract class BannerRepository {
  Future<Either<String, List<SliderModel>>> fetchBanner();
}

class BannerRepositoryImpl extends BaseRepository implements BannerRepository {
  final BannerProviderImpl _bannerProviderImpl;

  BannerRepositoryImpl({
    required super.networkInfoImpl,
    required BannerProviderImpl bannerProviderImpl,
  }) : _bannerProviderImpl = bannerProviderImpl;

  @override
  Future<Either<String, List<SliderModel>>> fetchBanner() async {
    final result = await baseRepo<List<SliderModel>>(
      excuteFunction: () async {
        return await _bannerProviderImpl.fetchBanner();
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }
}
