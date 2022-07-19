import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../service/firebase_services.dart';
import '../../service/service_locator.dart';
import '../../utils/validator.dart';

class AddViewModel extends ChangeNotifier {
  final AuthProvider _firebaseservice = locator<AuthProvider>();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String dropdownvalue = 'Personal';
  String? titleText;
  String? descriptionText;
  String? choice;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null && pickedS != selectedTime) {
      selectedTime = pickedS;
      notifyListeners();
    }
  }

  String datE() {
    final datee = DateFormat.yMMMd()

        // displaying formatted date
        .format(selectedDate);
    return datee;
  }

  String dateTimee() {
    final hour = selectedTime.hour.toString().padLeft(2, '0');
    final min = selectedTime.minute.toString().padLeft(2, '0');
    // ignore: non_constant_identifier_names
    final Datetimee = ('${hour}:${min}').toString();

    return Datetimee;
  }

  String? Function(String? value) get textValidator =>
      Validators.validateTextField;

  // String? Function(String? email) get emailValidator =>
  // Validators.emailValidator;
  Future<bool> saveUsertask() async {
    final user = _firebaseservice.auth.currentUser!.email;
    await _firebaseservice.creataskoc(titleController.text,
        descriptionController.text, dateTimee(), datE(), choice, user);

    return true;
  }

  var items = [
    'Personal',
    'Business',
  ];
}
