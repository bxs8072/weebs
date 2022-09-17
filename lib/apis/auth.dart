import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/firebase_auth_error_message.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final _authInstance = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Person? _fromFirebase(User? user) => Person(
        uid: user!.uid,
        photoURL: user.photoURL ?? "",
        email: user.email!,
      );

  //Listen to the user state => user == null || user.
  Stream<Person?> get stream => _authInstance.userChanges().map(_fromFirebase);

  Future<Person?> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If registration is successful them send account activation link to the registered email address
      await userCredential.user!.sendEmailVerification();

      return _fromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // Send error with specific message according to the error codes from firebase
      throw FirebaseAuthErrorMessage(e.code).message;
    }
  }

  Future<Person?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _fromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // Send error with specific message according to the error codes from firebase
      throw FirebaseAuthErrorMessage(e.code).message;
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      // Send password reset link to provided email address
      await _authInstance.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      // If invalid email or unregistered email then send error
      throw FirebaseAuthErrorMessage(e.code).message;
    }
  }

  Future<Person?> signInWithGoogle() async {
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _authInstance
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return _fromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth TOken',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  Future<void> logout() async {
    await _authInstance.signOut();
    await googleSignIn.signOut();
  }
}
