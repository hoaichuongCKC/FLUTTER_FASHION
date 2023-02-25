import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin FirebaseMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      required Function(UserCredential user) verificationCompleted,
      required Function(FirebaseAuthException p1) verificationFailed,
      required Function(String verificationId, int? resendToken) codeSent,
      required Function(String verificationId) codeAutoRetrievalTimeout,
      int? forceResendingToken,
      Duration timeoutDuration = const Duration(seconds: 30)}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async =>
            await _auth.signInWithCredential(credential).then(
              (value) {
                verificationCompleted(value);
              },
            ),
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: timeoutDuration,
        forceResendingToken: forceResendingToken);
  }

  Future<Either<String, UserCredential?>> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      final data = await _auth.signInWithCredential(credential);
      if (data.user != null) {
        return Right(data);
      } else {
        return const Left("Invalid-code");
      }
    } on FirebaseAuthException catch (e) {
      // Handle sign in errors here
      return Left(e.message!);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
