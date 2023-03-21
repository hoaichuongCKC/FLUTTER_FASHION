import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/network_provider/auth_provider.dart';
import 'package:flutter_fashion/core/base/params/register.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/models/response_data.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class AuthRepository {
  Future<Either<String, ResponseData>> login(String phone, String password);
  Future<Either<String, ResponseData>> loginGoogle(
      String fullname, String email);
  Future<Either<String, ResponseData>> register(RegisterParams params);
  Future<Either<String, ResponseData>> loggout();
}

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthProviderImpl _authProviderImpl;

  AuthRepositoryImpl({
    required super.networkInfoImpl,
    required AuthProviderImpl authProviderImpl,
  }) : _authProviderImpl = authProviderImpl;

  @override
  Future<Either<String, ResponseData>> login(
      String phone, String password) async {
    final result = await baseRepo<ResponseData>(
      excuteFunction: () async {
        final data = await _authProviderImpl.login(phone, password);
        HydratedBloc.storage.write(KeyStorage.token, data.data);

        return data;
      },
    );

    return result.fold((error) => Left(error), (r) => Right(r));
  }

  /// A function that calls the loggout function in the AuthProviderImpl class.
  ///
  /// Returns:
  ///   Either<String, ResponseData>
  @override
  Future<Either<String, ResponseData>> loggout() async {
    /// A function that is used to handle the error and success of the function.
    final result = await baseRepo<ResponseData>(
      excuteFunction: () async {
        final data = await _authProviderImpl.loggout();
        if (data.status) {
          HydratedBloc.storage.delete(KeyStorage.token);
        }
        return data;
      },
    );
    return result.fold((error) => Left(error), (r) => Right(r));
  }

  @override
  Future<Either<String, ResponseData>> register(RegisterParams params) async {
    /// A function that is used to handle the error and success of the function.
    final result = await baseRepo<ResponseData>(
      excuteFunction: () async {
        final data = await _authProviderImpl.register(params);
        return data;
      },
    );
    return result.fold((error) => Left(error), (r) => Right(r));
  }

  @override
  Future<Either<String, ResponseData>> loginGoogle(
      String fullname, String email) async {
    final result = await baseRepo<ResponseData>(
      excuteFunction: () async {
        final data = await _authProviderImpl.loginGoogle(fullname, email);
        HydratedBloc.storage.write(KeyStorage.token, data.data);
        return data;
      },
    );
    return result.fold((error) => Left(error), (r) => Right(r));
  }
}
