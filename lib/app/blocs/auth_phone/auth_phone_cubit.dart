import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/repositories/auth_repository.dart';
import 'package:flutter_fashion/core/firebase/firebase_service.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_phone_state.dart';
part 'auth_phone_cubit.freezed.dart';

class AuthPhoneCubit extends Cubit<AuthPhoneState> with FirebaseMixin {
  final AuthRepositoryImpl _auth;
  AuthPhoneCubit({required AuthRepositoryImpl auth})
      : _auth = auth,
        super(const AuthPhoneState.initial());

  String _verificationId = "";

  void authPhone(
    String phoneNumber,
    BuildContext context,
    String payload, {
    bool isResend = false,
  }) async {
    emit(const AuthPhoneState.loading());

    if (!isResend) loadingAlert(context: context);

    final result = await _auth.checkPhone(phoneNumber);

    result.fold(
      (l) => emit(const AuthPhoneState.error()),
      (response) async {
        final statusCode = response.data[0];

        if (statusCode == 200) {
          await _handleAuthPhoneFirebase(
            phoneNumber,
            isResend,
            context,
            payload,
          );
        } else {
          AppRoutes.router.pop();
          errorAlert(
            context: context,
            message: AppLocalizations.of(context)!
                .registerd_phone_number_in_the_system,
          );
        }
      },
    );
  }

  _handleAuthPhoneFirebase(
    String phoneNumber,
    bool isResend,
    BuildContext context,
    String payload,
  ) async {
    await verifyPhoneNumber(
      phoneNumber: "+84$phoneNumber",
      verificationCompleted: (user) {
        if (isResend) return;
      },
      verificationFailed: (FirebaseAuthException exception) {
        // remove loading popup
        if (!isResend) AppRoutes.router.pop();

        errorAlert(context: context, message: exception.message!);

        emit(const AuthPhoneState.error());
      },
      codeSent: (verificationId, resendToken) {
        log("verification nhận được: $verificationId");
        _verificationId = verificationId;

        emit(const AuthPhoneState.authPhoneSuccess());

        if (!isResend) {
          AppRoutes.router.pop();
          _handleNavigator(payload, phoneNumber);
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log("codeAutoRetrievalTimeout verification nhận được: $verificationId");
        _verificationId = verificationId;
        _handleNavigator(payload, phoneNumber);
      },
    );
  }

  void _handleNavigator(String payload, String phone) {
    AppRoutes.router.pushNamed(
      Names.OTP,
      queryParams: {
        "phone": phone,
        "verificationId": _verificationId,
        "payload": payload,
      },
    );
  }

  void verifyOtp(
    String phoneNumber,
    String smsCode,
    BuildContext context,
    String verificationId,
    String payload,
  ) async {
    emit(const AuthPhoneState.loading());
    loadingAlert(context: context);

    final result = await signInWithPhoneNumber(verificationId, smsCode);

    //dispose popup loading
    AppRoutes.router.pop();

    result.fold(
      (errorFirebase) {
        emit(const AuthPhoneState.error());
        errorAlert(context: context, message: errorFirebase);
      },
      (userCredential) {
        AppRoutes.router.pushNamed(
          payload,
          queryParams: {
            "phone": phoneNumber,
          },
        );
        emit(const AuthPhoneState.verifyOtpSuccess());

        signOut();
      },
    );
  }
}
