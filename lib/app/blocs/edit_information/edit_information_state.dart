// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_information_cubit.dart';

enum EditStatus { loading, error, success, init, onChangeValue }

class EditInformationState extends Equatable {
  final String username;
  final String fullname;
  final String phone;
  final String email;
  final XFile? image;
  final EditStatus status;

  const EditInformationState({
    this.username = "",
    this.fullname = "",
    this.phone = "",
    this.email = "",
    this.status = EditStatus.init,
    this.image,
  });

  @override
  List<Object?> get props => [username, fullname, phone, email, image, status];
  Map<String, String> toJson() => {
        "username": username,
        "fullname": fullname,
        "phone": phone,
        "email": email,
      };
  EditInformationState copyWith({
    String? username,
    String? fullname,
    String? phone,
    String? email,
    XFile? image,
    EditStatus? status,
  }) {
    return EditInformationState(
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      "Model: $username| $fullname| $phone| $email| $image| $status";
}
