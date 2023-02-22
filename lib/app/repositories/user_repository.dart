import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/blocs/change_password/change_password_cubit.dart';
import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/network_provider/user_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/models/response_data.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/edit_information/edit_information_cubit.dart';

abstract class UserRepository {
  Future<Either<String, UserModel>> me();
  Future<Either<String, UserModel>> update(
      {required EditInformationState param, XFile? imageFile});

  Future<Either<String, ResponseData>> changePassword(
      {required ChangePasswordState param});
}

class UserRepositoryImpl extends BaseRepository implements UserRepository {
  final UserProviderImpl _userProviderImpl;

  UserRepositoryImpl(
      {required super.networkInfoImpl,
      required UserProviderImpl userProviderImpl})
      : _userProviderImpl = userProviderImpl;

  String? currentError;

  @override
  Future<Either<String, UserModel>> me() async {
    dynamic currentData;
    await baseRepo<String, UserModel>(
      excuteFunction: () async => await _userProviderImpl.me(),
      errorCallback: (String? error) {
        if (error != null) currentError = error;
      },
      successCallback: (UserModel? data) {
        if (data != null) currentData = data;
      },
    );
    if (currentData != null) {
      return Right(currentData);
    }
    return Left(currentError!);
  }

  @override
  Future<Either<String, UserModel>> update(
      {required EditInformationState param, XFile? imageFile}) async {
    dynamic currentData;
    await baseRepo<String, UserModel>(
      excuteFunction: () async =>
          await _userProviderImpl.update(param: param, imageFile: imageFile),
      errorCallback: (String? error) {
        if (error != null) currentError = error;
      },
      successCallback: (UserModel? data) {
        if (data != null) currentData = data;
      },
    );
    if (currentData != null) {
      return Right(currentData);
    }
    return Left(currentError!);
  }

  @override
  Future<Either<String, ResponseData>> changePassword(
      {required ChangePasswordState param}) async {
    dynamic currentData;
    await baseRepo<String, ResponseData>(
      excuteFunction: () async =>
          await _userProviderImpl.changePassword(param: param),
      errorCallback: (String? error) {
        if (error != null) currentError = error;
      },
      successCallback: (ResponseData? data) {
        if (data != null) currentData = data;
      },
    );
    if (currentData != null) {
      return Right(currentData);
    }
    return Left(currentError!);
  }
}
