// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_event.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/repositories/auth_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/routes/app_routes.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryImpl _authRepositoryImpl;
  AuthCubit({required AuthRepositoryImpl auth})
      : _authRepositoryImpl = auth,
        super(const AuthState());

  void call(AuthEvent event,
      {Map<String, dynamic>? param, BuildContext? context}) {
    switch (event) {
      case AuthEvent.changedPhone:
        if (param != null) _onChangedPhone(param);
        break;
      case AuthEvent.changedPassword:
        if (param != null) _onChangedPassword(param);
        break;
      case AuthEvent.submitLogin:
        if (context != null) _onSubmitLogin(context);
        break;
      case AuthEvent.loggout:
        if (context != null) _onSubmitLoggout(context);
        break;
      default:
    }
  }

  void _onChangedPhone(Map<String, dynamic>? param) {
    if (param != null) {
      if (param["phoneNumber"] != null) {
        emit(state.copyWith(
            phoneNumber: param["phoneNumber"], status: LoginStatus.init));
      }
    } else {
      throw ParamRequestException();
    }
  }

  void _onChangedPassword(Map<String, dynamic>? param) {
    if (param != null) {
      if (param["password"] != null) {
        emit(state.copyWith(
            password: param["password"], status: LoginStatus.init));
      }
    } else {
      throw ParamRequestException();
    }
  }

  void _onSubmitLogin(BuildContext context) async {
    emit(state.copyWith(status: LoginStatus.loading));
    loadingAlert(context: context);

    final String phone = state.phoneNumber;
    final String password = state.password;
    final result = await _authRepositoryImpl.login(phone, password);

    result.fold(
      (error) {
        emit(state.copyWith(status: LoginStatus.error));
        errorAlert(context: context, message: error);
      },
      (dataReposonse) {
        if (dataReposonse.status) {
          AppRoutes.go(Routes.HOME);
          emit(state.copyWith(status: LoginStatus.success));
        }
      },
    );
  }

  void _onSubmitLoggout(BuildContext context) async {
    final result = await _authRepositoryImpl.loggout();

    result.fold(
      (error) {
        emit(state.copyWith(status: LoginStatus.error));
        errorAlert(context: context, message: error);
      },
      (dataReposonse) {
        if (dataReposonse.status) {
          HydratedBloc.storage.delete(KeyStorage.token);
          AppRoutes.go(Routes.LOGIN);
          emit(const AuthState());
        }
      },
    );
  }
}
