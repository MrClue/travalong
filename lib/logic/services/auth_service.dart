import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/presentation/screens/screens.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // saving the userdata
  Future saveUserData(AppUser user) async {
    final json = user.toJson();
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(json);
  }

  // ! Register user
  Future registerUser(String name, String gender, int age, String email,
      String password) async {
    try {
      // User is FirebaseAuth user account that is used to sign in
      User authUser = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // AppUser refers to the user in the app. The current user and its data.
      AppUser user = AppUser(
        name: name,
        age: age,
        gender: gender,
        email: email,
        uid: authUser.uid,
      );

      // call our database service to update the user data.
      await saveUserData(user);
      //DatabaseService(uid: authUser.uid).saveUserData(user);

      return true;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } catch (e) {
      return false;
    }
  }

// ! Sign in
  Future signIn(context, econtroller, pcontroller) async {
    try {
      final User? user = (await firebaseAuth.signInWithEmailAndPassword(
        email: econtroller.text.trim(),
        password: pcontroller.text.trim(),
      ))
          .user;

      if (user != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TravalongNavbar()),
        );
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        showDialog(
          context: context,
          builder: (context) {
            return const SimpleDialog(
              title: Text('Error'),
              children: [
                Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text('Incorrect email or password')),
              ],
            );
          },
        );
      } else {
        // Rethrow the exception if it's not a FirebaseAuthException
        rethrow;
      }
    }
  }

// ! Sign out
  Future signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
