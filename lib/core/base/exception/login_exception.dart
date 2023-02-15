class ParamInputException implements Exception {
  static const String message = 'Số điện thoại hoặc mật khẩu không trùng khớp';

  @override
  String toString() {
    return message;
  }
}
