import 'package:flutter/material.dart';

import 'package:wow/buisness_logic/view_model/Homeviewmodel.dart';

import '../../service/firebase_services.dart';
import '../../service/service_locator.dart';
import '../../utils/validator.dart';

class AccountViewModel extends ChangeNotifier {
  final AuthProvider _firebaseservice = locator<AuthProvider>();
  final HomeViewModel homeViewModel = locator<HomeViewModel>();

  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  String? date;
  TextEditingController countryValue = TextEditingController();
  TextEditingController stateValue = TextEditingController();
  TextEditingController cityValue = TextEditingController();
  bool _isDateselected = true;

  bool get isDateSelected => _isDateselected;

  set isDateSelected(bool val) {
    _isDateselected = val;
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();

  Future<bool> updateUserCred(fnamecontroller, lnamecontroller, countryValue,
      stateValue, cityValue) async {
    final user = _firebaseservice.auth.currentUser!.email;
    await _firebaseservice.updatedoc(fnamecontroller, lnamecontroller,
        countryValue, stateValue, cityValue, user);

    return true;
  }

  String? Function(String? val) get textfieldValidator =>
      Validators.validateTextField;

  // Future fetchdetails() async {
  //   var collection = _firebaseservice.store.collection('Usser');
  //   //userUid is the current auth user
  //   final user = _firebaseservice.auth.currentUser!;

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
