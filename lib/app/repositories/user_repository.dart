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

  UserRepositoryImpl({
    required super.networkInfoImpl,
    required UserProviderImpl userProviderImpl,
  }) : _userProviderImpl = userProviderImpl;

  String? currentError;

  @override
  Future<Either<String, UserModel>> me() async {
    final result = await baseRepo<UserModel>(
      excuteFunction: () async => await _userProviderImpl.me(),
    );
    return result.fold((error) => Left(error), (r) => Right(r));
  }

  @override
  Future<Either<String, UserModel>> update(
      {required EditInformationState param, XFile? imageFile}) async {
    final result = await baseRepo<UserModel>(
      excuteFunction: () async =>
          await _userProviderImpl.update(param: param, imageFile: imageFile),
    );
    return result.fold((error) => Left(error), (r) => Right(r));
  }

  @override
  Future<Either<String, ResponseData>> changePassword(
      {required ChangePasswordState param}) async {
    final result = await baseRepo<ResponseData>(
      excuteFunction: () async =>
          await _userProviderImpl.changePassword(param: param),
    );
    return result.fold((error) => Left(error), (r) => Right(r));
  }
}
