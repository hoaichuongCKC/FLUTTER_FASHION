import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/app/network_provider/notification_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';

abstract class NotificationRepository {
  Future<Either<String, List<NotificationModel>>> fetch(int page);
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
}
