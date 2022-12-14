import 'package:firebase_auth/firebase_auth.dart';
import 'package:travalong/data/model/user.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ! Register user
  Future registerUser(String name, String email, String password) async {
    try {
      // User is FirebaseAuth user account that is used to sign in
      User authUser = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // AppUser refers to the user in the app. The current user and its data.
      AppUser user = AppUser(
        name: name,
        email: email,
        uid: authUser.uid,
      );

      if (authUser != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: authUser.uid).saveUserData(user);
        return true;
      } else if (authUser == null) {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

// ! Sign in

// ! Sign out
  Future signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
