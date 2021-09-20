import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kwayes/model/user.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create user obj based on FirebaseUser
  Userr _userFromFirebaseUser(User user) {
    return user != null ? Userr(uid: user.uid, email: user.email) : null;
  }

  //auth change user stream
  Stream<Userr> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Sign in with Email & Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      {
        print(e.toString());
        return e;
      }
    }
  }

  //SignIn with Google Sign-In
  Future signInWithGoogleSignIn() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.email).get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.email).set({
          'Email': user.email,
          'Name': user.displayName,
          'photo_url': user.photoURL
        });
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithAppleSignIn() async {
    try {
      final AuthorizationResult result = await TheAppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      final appleIdCredential = result.credential;
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: String.fromCharCodes(appleIdCredential.identityToken),
        accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
      );
      // ignore: non_constant_identifier_names
      UserCredential AuthResult = await _auth.signInWithCredential(credential);
      User user = AuthResult.user;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.email).get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.email).set({
          'Email': user.email,
          'Name': user.displayName,
          'photo_url': user.photoURL
        });
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken.token);
      UserCredential result =
          await _auth.signInWithCredential(facebookAuthCredential);
      User user = result.user;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.email).get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.email).set({
          'Email': user.email,
          'Name': user.displayName,
          'photo_url': user.photoURL
        });
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with Email & Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      {
        print(e.toString());
        return null;
      }
    }
  }

  //Reset Password
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
