import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class represents the Authenticationservice for the app
class AuthService with ChangeNotifier {
  // variables of the class
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Method to sign in by using the signInWithEmailAndPassword method from
  // firebase_auth package
  Future<UserCredential> signIn(String email, String password) async {
    // try-block which tries to sign in with the given user credentials
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // Method returns the credentials
      return userCredential;
      // If theres a problem the method throws an exception and returns the error
      // code
    } on FirebaseAuthException catch (error) {
      throw error.code;
    }
  }

  // Method to register a user by using their email and a wish password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    // Try-block which creates a new user with their email and self-made
    // password by using the createUserWithEmailAndPassword method from
    // firebase package
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // returns the created user credentials
      return userCredential;
      // If an error occurs an exception will be thrown with the specific error
      // code
    } on FirebaseAuthException catch (error) {
      throw error.code;
    }
  }

  // Sign out method which uses the signOut method from firebase_auth package
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
