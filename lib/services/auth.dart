import 'package:firebase_auth/firebase_auth.dart';
import 'package:summerapp/models/countryInfo.dart';
import 'package:summerapp/models/user.dart';
import 'package:summerapp/services/usersCollection.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid, emailVerified: user.emailVerified) : null;
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }

  Future signOut() async {
    try{
      if(user == null) {
        return await _auth.signOut();
      }
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  // register with email & password
  Future registerWithEmailAndPassword(String email, String password, String username) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await UsersCollection(uid: user!.uid).updateUserInfo(username);

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}