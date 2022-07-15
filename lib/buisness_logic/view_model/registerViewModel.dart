import 'package:flutter/material.dart';
import 'package:wow/service/firebase_services.dart';
import 'package:wow/service/service_locator.dart';

import '../../utils/validator.dart';

class RegisterViewmodel extends ChangeNotifier {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  bool _passwordVisible = true;

  final AuthProvider _firebaseservice = locator<AuthProvider>();

  bool get passwordVisible => _passwordVisible;
  TextEditingController get emailController => _emailcontroller;
  TextEditingController get passwordController => _passwordcontroller;

  String? Function(String? email) get emailValidator =>
      Validators.emailValidator;

  String? Function(String? password) get passwordValidator =>
      Validators.passwordValidator;

  set passwordVisible(bool val) {
    _passwordVisible = val;
    notifyListeners();
  }

  Future<void Function()?> gregister() async {
    _firebaseservice.googleLogin();
    return null;
  }

  Future<void Function()?> register() async {
    await _firebaseservice.signUp(
      _emailcontroller.text.trim(),
      _passwordcontroller.text,
    );

    return null;
  }

  Future<void Function()?> logout() async {
    await _firebaseservice.logOut();

    return null;
  }
}
