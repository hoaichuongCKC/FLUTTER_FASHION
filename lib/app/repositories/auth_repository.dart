import 'package:dartz/dartz.dart';

import 'package:flutter_fashion/app/network_provider/auth_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/models/response_data.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class AuthRepository {
  Future<Either<String, ResponseData>> login(String phone, String password);
  Future<Either<String, ResponseData>> loggout();
}

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthProviderImpl _authProviderImpl;

  const AuthRepositoryImpl(
      {required super.networkInfoImpl,
      required AuthProviderImpl authProviderImpl})
      : _authProviderImpl = authProviderImpl;

  @override
  Future<Either<String, ResponseData>> login(
      String phone, String password) async {
    ResponseData? currentData;
    String? currentError;

    await baseRepo<String, ResponseData>(
      excuteFunction: () async {
        final data = await _authProviderImpl.login(phone, password);

        HydratedBloc.storage.write(KeyStorage.token, data.data);

        return data;
      },
      errorCallback: (String? error) {
        if (error != null) currentError = error;
      },
      successCallback: (ResponseData? data) {
        if (data != null) currentData = data;
      },
    );
    if (currentData != null) {
      return Right(currentData!);
    }
    return Left(currentError!);
  }

  @override
  Future<Either<String, ResponseData>> loggout() async {
    ResponseData? currentData;
    String? currentError;

    await baseRepo<String, ResponseData>(
      excuteFunction: () async {
        final data = await _authProviderImpl.loggout();
        return data;
      },
      errorCallback: (String? error) {
        if (error != null) currentError = error;
      },
      successCallback: (ResponseData? data) {
        if (data != null) currentData = data;
      },
    );
    if (currentData != null) {
      return Right(currentData!);
    }
    return Left(currentError!);
  }
}
