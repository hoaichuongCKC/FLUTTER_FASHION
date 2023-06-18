import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/app/network_provider/notification_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/models/response_data.dart';

abstract class NotificationRepository {
  Future<Either<String, List<NotificationModel>>> fetch(int page);
  Future<Either<String, ResponseData>> delete(int idNoti);
}

class NotificationRepositoryImpl extends BaseRepository
    implements NotificationRepository {
  final NotificationProviderImpl _notificationProvider;

  NotificationRepositoryImpl({
    required super.networkInfoImpl,
    required NotificationProviderImpl notificationProvider,
  }) : _notificationProvider = notificationProvider;

  @override
  Future<Either<String, List<NotificationModel>>> fetch(int page) async {
    final result = await baseRepo<List<NotificationModel>>(
      excuteFunction: () async {
        return await _notificationProvider.fetchData(page);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, ResponseData>> delete(int idNoti) async {
    final result = await baseRepo<ResponseData>(
      excuteFunction: () async {
        return await _notificationProvider.delete(idNoti);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }
}
