part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.fetchCompleted(UserModel user) = _FetchCompleted;
  const factory UserState.failure(String error) = _Failure;
}
