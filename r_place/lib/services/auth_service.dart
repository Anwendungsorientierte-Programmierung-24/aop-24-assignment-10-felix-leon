import 'package:firebase_auth/firebase_auth.dart';

// class represents the Authenticationservice for the app
class AuthService {
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
      throw Exception(error.code);
    }
  }
}
