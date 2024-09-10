import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //get instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //SIGN IN
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    //sign user in
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      //save user in different doc
      _storage.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //SIGN UP
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    //sign user up
    try{
      UserCredential userCredential = 
        await _auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );
      //save user in a different document
      _storage.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        }
      );
      return userCredential;
    }
    //catch any errors
    on FirebaseAuthException catch (e) {
      //print("auth_service caught error");
      throw Exception(e.code);
    }
  }

  //SIGN OUT
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}