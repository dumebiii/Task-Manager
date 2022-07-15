import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../service/firebase_services.dart';
import '../../service/service_locator.dart';
import '../../utils/validator.dart';

class UserViewModel extends ChangeNotifier {
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();

  String? countryValue;
  String? stateValue;
  String? cityValue;
  DateTime selectedDate = DateTime.now();
  bool _isDateselected = true;

  final AuthProvider _firebaseservice = locator<AuthProvider>();

  TextEditingController get fnameController => _firstnamecontroller;

  TextEditingController get lnameController => _lastnamecontroller;
  bool get isDateSelected => _isDateselected;

  set isDateSelected(bool val) {
    _isDateselected = val;
    notifyListeners();
  }

  String? Function(String? val) get textfieldValidator =>
      Validators.validateTextField;

  String datE() {
    final datee = DateFormat.MMMMEEEEd()

        // displaying formatted date
        .format(selectedDate);
    return datee;
  }

  Future<bool> saveUserCred() async {
    final user = _firebaseservice.auth.currentUser!.email;
    await _firebaseservice.createdoc(fnameController.text, lnameController.text,
        datE(), countryValue, stateValue, cityValue, user);

    return true;
  }
}
