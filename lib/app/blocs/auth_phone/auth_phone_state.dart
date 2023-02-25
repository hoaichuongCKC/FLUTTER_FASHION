part of 'auth_phone_cubit.dart';

@freezed
class AuthPhoneState with _$AuthPhoneState {
  const factory AuthPhoneState.initial() = _Initial;
  const factory AuthPhoneState.loading() = _Loading;
  const factory AuthPhoneState.error() = _Error;
  const factory AuthPhoneState.authPhoneSuccess() = _AuthPhoneSuccess;
  const factory AuthPhoneState.verifyOtpSuccess() = _VerifyOtpSuccess;
}
