// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_password_cubit.dart';

@immutable
class ChangePasswordState extends Equatable {
  final String currentPass;
  final String newPass;
  final String confirmPass;
  final AppStatus status;
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const ChangePasswordState({
    this.currentPass = '',
    this.newPass = '',
    this.confirmPass = '',
    this.status = AppStatus.init,
  });

  @override
  List<Object?> get props => [currentPass, newPass, confirmPass, status];
  Map<String, String> toJson() => {
        "current_password": currentPass,
        "new_password": newPass,
      };
  ChangePasswordState copyWith({
    String? currentPass,
    String? newPass,
    String? confirmPass,
    AppStatus? status,
  }) {
    return ChangePasswordState(
      currentPass: currentPass ?? this.currentPass,
      newPass: newPass ?? this.newPass,
      confirmPass: confirmPass ?? this.confirmPass,
      status: status ?? this.status,
    );
  }
}
