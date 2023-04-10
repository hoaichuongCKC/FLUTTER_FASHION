import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/network_provider/notification_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/models/response_data.dart';

abstract class NotificationRepository {
  Future<Either<String, Map<String, dynamic>>> fetch(int page, String? type);
  Future<Either<String, ResponseData>> updateReadNoti(int idNoti, String? type);
}

class NotificationRepositoryImpl extends BaseRepository
    implements NotificationRepository {
  final NotificationProviderImpl _notificationProvider;

  NotificationRepositoryImpl({
    required super.networkInfoImpl,
    required NotificationProviderImpl notificationProvider,
  }) : _notificationProvider = notificationProvider;

  @override
  Future<Either<String, Map<String, dynamic>>> fetch(
      int page, String? type) async {
    final result = await baseRepo<Map<String, dynamic>>(
      excuteFunction: () async {
        return await _notificationProvider.fetchData(page, type);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, ResponseData>> updateReadNoti(
      int idNoti, String? type) async {
    final result = await baseRepo<ResponseData>(
      excuteFunction: () async {
        return await _notificationProvider.updateReadNoti(idNoti, type);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }
}
