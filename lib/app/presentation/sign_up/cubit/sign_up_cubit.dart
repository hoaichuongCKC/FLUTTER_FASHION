import 'package:bloc/bloc.dart';

enum SignUpUIState {
  enterPhone,
  enterOTP,
  fillingInfor,
  enterPassword,
}

class SignUpUICubit extends Cubit<int> {
  SignUpUICubit(super.initialState);

  void nextStep(SignUpUIState state) {
    switch (state) {
      case SignUpUIState.enterPhone:
        emit(0);
        break;
      case SignUpUIState.enterOTP:
        emit(1);
        break;
      case SignUpUIState.fillingInfor:
        emit(2);
        break;
      default:
        emit(3);
    }
  }
}
