import 'package:flutter/material.dart';

import '../../service/firebase_services.dart';
import '../../service/service_locator.dart';
import '../../utils/validator.dart';

class LoginViewModel extends ChangeNotifier {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  bool _passwordVisible = true;

  final AuthProvider _firebaseservice = locator<AuthProvider>();
  TextEditingController get emailController => _emailcontroller;

  TextEditingController get passwordController => _passwordcontroller;

  String? Function(String? email) get emailValidator =>
      Validators.emailValidator;

  String? Function(String? password) get passwordValidator =>
      Validators.passwordValidator;

  bool get passwordVisible => _passwordVisible;

  set passwordVisible(bool val) {
    _passwordVisible = val;
    notifyListeners();
  }

  Future<void Function()?> gregister() async {
    await _firebaseservice.googleLogin();
    await fetchdetails();
    return null;
  }

  Future<Map<String, dynamic>?> fetchdetails() async {
    var collection = _firebaseservice.store.collection('Usser');
    //userUid is the current auth user
    final user = _firebaseservice.auth.currentUser!;

    var docSnapshot = await collection.doc(user.uid).get();

    Map<String, dynamic>? data = docSnapshot.data();
    debugPrint('$data');
    return data;
  }

  Future login() async {
    await _firebaseservice.signIn(
      _emailcontroller.text.trim(),
      _passwordcontroller.text,
    );
  }
}
