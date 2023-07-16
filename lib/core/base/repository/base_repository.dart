import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import '../exception/login_exception.dart';

class BaseRepository {
  final NetworkInfoImpl _networkInfoImpl;

  const BaseRepository({required NetworkInfoImpl networkInfoImpl})
      : _networkInfoImpl = networkInfoImpl;

  Future<Either<String, T>> baseRepo<T>({
    required Future<T> Function() excuteFunction,
  }) async {
    try {
      if (_networkInfoImpl.status == NetWorkStatus.successfully) {
        final data = await excuteFunction();

        return Right(data);
      } else {
        return const Left(InternetException.message);
      }
    } on ServerException catch (error) {
      return Left(error.toString());
    } on ConnectTimeoutHttpException catch (error) {
      return Left(error.toString());
    } on ParamInputException catch (error) {
      return Left(error.toString());
    } on AuthenticatedException catch (error) {
      return Left(error.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
