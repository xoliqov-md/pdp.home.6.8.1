

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../data/shared/prefc.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<User?> signInUser( BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword (email: email, password: password);
      final User? firebaseUser = await _auth.currentUser;
      print (firebaseUser.toString());
      return firebaseUser;
    } catch (e) {
      print(e);
    }
    return null;
  }
  static Future<User?> signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = authResult.user; print(firebaseUser.toString());
      return firebaseUser;
    } catch (e) {
      print(e);
    }
    return null;
  }
  static void signOutUser(BuildContext context) {
    _auth.signOut();
    Prefs.removeUserId().then((value) {
      Navigator.pop(context);
    });
  }
}