// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final String phoneNumber;

  final String password;

  final AppStatus status;
  const AuthState({
    this.phoneNumber = "",
    this.password = "",
    this.status = AppStatus.init,
  });

  @override
  List<Object?> get props => [phoneNumber, password, status];

  AuthState copyWith({
    String? phoneNumber,
    String? password,
    String? messageError,
    AppStatus? status,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
