import 'package:bottle_crew/models/user.dart';
import 'package:bottle_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based opn firebase
  BCUser? _userfromFireBase(User? userCredential) {
    return userCredential != null ? BCUser(uid: userCredential.uid) : null;
  }

  // auth chaNge user Stream

  Stream<BCUser?> get user {
    return _auth.authStateChanges().map(_userfromFireBase);
  }

  //sign in anon
  Future signinAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and pass
  Future signinWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //register with email pass
  Future registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      DataBaseService(uid: userCredential.user!.uid)
          .updateUserDate('Alcohol', 'Palm Wine', 0);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too much');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exisats for the email');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
