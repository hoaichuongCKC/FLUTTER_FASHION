import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/network/network_info.dart';

import '../exception/login_exception.dart';

class BaseRepository {
  final NetworkInfoImpl _networkInfoImpl;

  const BaseRepository({required NetworkInfoImpl networkInfoImpl})
      : _networkInfoImpl = networkInfoImpl;

  Future<dynamic> baseRepo<R, T>(
      {required Future<T> Function() excuteFunction,
      required void Function(T?) successCallback,
      required void Function(R?) errorCallback}) async {
    try {
      if (_networkInfoImpl.status == NetWorkStatus.successfully) {
        final data = await excuteFunction();
        return successCallback(data);
      } else {
        return errorCallback(InternetException.message as R);
      }
    } on ServerException catch (error) {
      return errorCallback(error.toString() as R);
    } on ConnectTimeoutHttpException catch (error) {
      return errorCallback(error.toString() as R);
    } on ParamInputException catch (error) {
      return errorCallback(error.toString() as R);
    } on AuthenticatedException catch (error) {
      return errorCallback(error.toString() as R);
    } catch (e) {
      return errorCallback(e.toString() as R);
    }
  }
}
