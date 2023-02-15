import 'package:flutter_fashion/app/presentation/introduction/export.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';

class AlertControl {
  AlertControl._();

  static AlertControl instance = AlertControl._();

  bool _isHasAlert = false;

  bool get isHasAlert => _isHasAlert;

  void updateShow() => _isHasAlert = !_isHasAlert;

  void showAlertError(BuildContext context) {
    errorAlert(context: context);
  }

  void showAlertLoading(BuildContext context) {
    loadingAlert(context: context);
  }
}
