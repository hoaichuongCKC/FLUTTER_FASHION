import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/core/firebase/firebase_service.dart';

import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_phone_state.dart';
part 'auth_phone_cubit.freezed.dart';

class AuthPhoneCubit extends Cubit<AuthPhoneState> with FirebaseMixin {
  AuthPhoneCubit() : super(const AuthPhoneState.initial());

  String _verificationId = "";

  void authPhone(String phoneNumber, BuildContext context,
      {bool isResend = false}) async {
    emit(const AuthPhoneState.loading());
    loadingAlert(context: context);

    await verifyPhoneNumber(
        phoneNumber: "+84$phoneNumber",
        verificationCompleted: (user) {
          AppRoutes.pushNamed(
            Names.OTP,
            queryParams: {
              "phone": phoneNumber,
              "verificationId": _verificationId,
            },
          );
        },
        verificationFailed: (FirebaseAuthException exception) {
          // remove loading popup
          AppRoutes.pop();

          errorAlert(context: context, message: exception.message!);
          emit(const AuthPhoneState.error());
        },
        codeSent: (verificationId, resendToken) {
          _verificationId = verificationId;

          AppRoutes.pop();
          emit(const AuthPhoneState.authPhoneSuccess());
        },
        codeAutoRetrievalTimeout: (verificationId) => AppRoutes.pushNamed(
              Names.OTP,
              queryParams: {
                "phone": phoneNumber,
                "verificationId": verificationId,
              },
            ));
  }

  void verifyOtp(String phoneNumber, String smsCode, String verificationId,
      BuildContext context) async {
    emit(const AuthPhoneState.loading());
    loadingAlert(context: context);

    final result = await signInWithPhoneNumber(verificationId, smsCode);

    //dispose popup loading
    AppRoutes.pop();

    result.fold(
      (errorFirebase) {
        emit(const AuthPhoneState.error());
        errorAlert(context: context, message: errorFirebase);
      },
      (userCredential) {
        emit(const AuthPhoneState.verifyOtpSuccess());
        AppRoutes.push(Routes.REGISTER);
      },
    );
  }
}
