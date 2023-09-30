import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swipeswap/firebase_options.dart';

/// A class for handling authentication and managing the user auth state
/// Currently only supports google authentication
/// May support email and password validation at some point in the future
class AuthService {
  /// Uses the [HTTP](package:google_sign_in/google_sign_in.dart) package to
  /// authenticate using Google credentials
  /// Signs the user into the Firebase backend so data can be updated
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }

  //sign out
  Future<bool?> signOut() async {
    try {
      try {
        await GoogleSignIn().disconnect();
      } on Exception catch (e) {
        print(e);
      }
      await FirebaseAuth.instance.signOut();

      return true; //sign out
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
