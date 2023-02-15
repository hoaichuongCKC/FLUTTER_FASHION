// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

enum LoginStatus { init, loading, error, success }

class AuthState extends Equatable {
  final String phoneNumber;

  final String password;

  final LoginStatus status;
  const AuthState({
    this.phoneNumber = "",
    this.password = " ",
    this.status = LoginStatus.init,
  });

  @override
  List<Object?> get props => [phoneNumber, password, status];

  AuthState copyWith({
    String? phoneNumber,
    String? password,
    String? messageError,
    LoginStatus? status,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
