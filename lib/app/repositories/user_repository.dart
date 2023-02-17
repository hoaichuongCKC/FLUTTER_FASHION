import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/network_provider/user_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';

abstract class UserRepository {
  Future<Either<String, UserModel>> me();
}

class UserRepositoryImpl extends BaseRepository implements UserRepository {
  final UserProviderImpl _userProviderImpl;

  const UserRepositoryImpl(
      {required super.networkInfoImpl,
      required UserProviderImpl userProviderImpl})
      : _userProviderImpl = userProviderImpl;

  @override
  Future<Either<String, UserModel>> me() async {
    UserModel? currentData;
    String? currentError;

    await baseRepo<String, UserModel>(
      excuteFunction: () async {
        final data = await _userProviderImpl.me();

        return data;
      },
      errorCallback: (String? error) {
        if (error != null) currentError = error;
      },
      successCallback: (UserModel? data) {
        if (data != null) currentData = data;
      },
    );
    if (currentData != null) {
      return Right(currentData!);
    }
    return Left(currentError!);
  }
}
