import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fashion/app/presentation/forgot_password/forgot_password_page.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/presentation/sign_up/sign_up_page.dart';
import 'package:flutter_fashion/app/repositories/auth_repository.dart';
import 'package:flutter_fashion/core/firebase/firebase_service.dart';
import 'package:flutter_fashion/utils/alert/dialog.dart';
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

  bool get isSuccess => state.whenOrNull(
        authPhoneSuccess: () => true,
      )!;

  void phoneAuth(
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

        if (payload == Names.REGISTER) {
          if (statusCode != 201) {
            AppRoutes.router.pop();
            showCustomDialog(
              context,
              title: "Authentication phone",
              content: AppLocalizations.of(context)!
                  .registerd_phone_number_in_the_system,
            );
            return;
          }
        } else {
          if (statusCode != 200) {
            AppRoutes.router.pop();
            showCustomDialog(
              context,
              icon: SvgPicture.asset("assets/icons/error.svg"),
              title: AppLocalizations.of(context)!.notificationPage,
              content: AppLocalizations.of(context)!
                  .phone_number_not_registered_in_the_system,
            );
            return;
          }
        }
        await _handleAuthPhoneFirebase(
          phoneNumber,
          isResend,
          context,
          payload,
        );
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

        showCustomDialog(
          context,
          icon: SvgPicture.asset("assets/icons/error.svg"),
          title: AppLocalizations.of(context)!.notificationPage,
          content: exception.message!,
        );

        emit(const AuthPhoneState.error());
      },
      codeSent: (verificationId, resendToken) {
        log("verification nhận được: $verificationId");
        if (payload == Names.FORGOT_PASSWORD) {
          ForgotPasswordPage.verificationId = verificationId;
        } else {
          SignUpPage.verificationId = verificationId;
        }

        emit(const AuthPhoneState.authPhoneSuccess());

        if (!isResend) {
          AppRoutes.router.pop();
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
        if (payload == Names.FORGOT_PASSWORD) {
          ForgotPasswordPage.verificationId = verificationId;
        } else {
          SignUpPage.verificationId = verificationId;
        }
        log("codeAutoRetrievalTimeout");
      },
    );
  }

  void verifyOtp(
    String phoneNumber,
    String smsCode,
    BuildContext context,
    String verificationId,
  ) async {
    emit(const AuthPhoneState.loading());
    loadingAlert(context: context);

    final result = await signInWithPhoneNumber(verificationId, smsCode);

    //dispose popup loading
    AppRoutes.router.pop();

    result.fold(
      (errorFirebase) {
        emit(const AuthPhoneState.error());
        showCustomDialog(
          context,
          icon: SvgPicture.asset("assets/icons/error.svg"),
          title: AppLocalizations.of(context)!.notificationPage,
          content: errorFirebase,
        );
      },
      (userCredential) {
        emit(const AuthPhoneState.verifyOtpSuccess());

        signOut();
      },
    );
  }
}
