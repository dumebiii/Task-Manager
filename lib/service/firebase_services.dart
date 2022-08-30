import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// This class handles authentication with provider state management
class AuthProvider extends ChangeNotifier {
  //initilializing firebase authentication
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;

  Stream<User?> get onAuthStateChanged => auth.authStateChanges();

  Future<User?> getCurrent() async {
    return auth.currentUser;
  }

  // GoogleSignInAccount? _guser;

  // GoogleSignInAccount get ugser => _guser!;

  Future googleLogin() async {
    final googlesignIn = GoogleSignIn();
    final googleUser = await googlesignIn.signIn();
    if (googleUser != null) {
      // _guser = googleUser;

      final googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
    }
  }

  Future signUp(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);

    return true;
  }

  Future signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> logOut() async {
    await auth.signOut();

    return true;
  }

  //initializing firebase user profile
  final CollectionReference _usser =
      FirebaseFirestore.instance.collection('Usser');

  createdoc(
    fname,
    lname,
    dob,
    country,
    state,
    city,
    user,
  ) {
    _usser.doc(auth.currentUser!.uid).set({
      // _usser.add({
      'fname': fname,
      'lname': lname,
      'dob': dob,
      'country': country,
      'state': state,
      'city': city,
      'user': user
    });
  }

  updatedoc(
    fname,
    lname,
    country,
    state,
    city,
    user,
  ) {
    _usser.doc(auth.currentUser!.uid).update({
      // _usser.add({
      'fname': fname,
      'lname': lname,

      'country': country,
      'state': state,
      'city': city,
      'user': user
    });
  }

  final CollectionReference _ttask =
      FirebaseFirestore.instance.collection('Task');
  creataskoc(titleText, descriptionText, dueDatetime, date, choice, user) {
    _ttask.add({
      'title': titleText,
      'description': descriptionText,
      'dueDatetime': dueDatetime,
      'date': date,
      'choice': choice,
      'user': user,
    });
  }

  // Future fetchdetails() async {
  //   var collection = store.collection('Usser');
  //   //userUid is the current auth user
  //   final user = auth.currentUser!;

  //   var docSnapshot = await collection.doc(user.uid).get();

  //   Map<String, dynamic>? data = docSnapshot.data();
  //   print(data);

  //   // fname = data!['fname'];
  //   // lname = data['lname'];
  //   // country = data['country'];
  //   // email = data['user'];
  //   // state = data['state'];
  //   // city = data['city'];
  //   return data;
  // }
}
