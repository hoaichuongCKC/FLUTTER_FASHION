// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class RegisterParams extends Equatable {
  final String fullname;
  final String phone;
  final String email;
  final String password;
  final XFile image;
  const RegisterParams({
    required this.fullname,
    required this.phone,
    required this.email,
    required this.password,
    required this.image,
  });

  Map<String, String> toJson() => {
        "fullname": fullname,
        "phone": phone,
        "email": email,
        "password": password,
      };

  @override
  List<Object?> get props => [fullname, phone, email, password, image];
}
