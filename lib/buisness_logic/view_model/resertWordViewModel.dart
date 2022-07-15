// ignore: file_names
import 'package:flutter/cupertino.dart';

import '../../service/firebase_services.dart';
import '../../service/service_locator.dart';
import '../../utils/validator.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final AuthProvider _firebaseservice = locator<AuthProvider>();
  TextEditingController emailController = TextEditingController();

  String? Function(String? email) get emailValidator =>
      Validators.emailValidator;

  Future resetPassword() async {
    await _firebaseservice.auth
        .sendPasswordResetEmail(email: emailController.text);
  }
}
