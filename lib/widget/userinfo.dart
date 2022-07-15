import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:csc_picker/csc_picker.dart';
import 'package:wow/widget/reuse_widget.dart';

import '../service/firebase_services.dart';

class Userd extends StatefulWidget {
  const Userd({Key? key}) : super(key: key);

  @override
  State<Userd> createState() => _UserdState();
}

class _UserdState extends State<Userd> {
  final _formKey = GlobalKey<FormState>();
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  String? fname;
  String? lname;
  String? dob;
  String? countryValue;
  String? stateValue;
  String? cityValue;
  DateTime selectedDate = DateTime.now();
  bool isDateselected = true;
  // bool isCountry = true;
  // bool isState = true;
  // bool isCity = true;
  final CollectionReference _usser =
      FirebaseFirestore.instance.collection('User');
  _createdoc(
    fname,
    lname,
    country,
    state,
    city,
    user,
  ) async {
    _usser.add({
      'fname': fname,
      'lname': lname,
      'country': country,
      'state': state,
      'City': city,
      'user': user
    });
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != selectedDate) {
                  setState(() {
                    isDateselected = false;
                    selectedDate = value;
                  });
                }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 1800,
              maximumYear: 2090,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Consumer<AuthProvider>(builder: (context, autth, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'First name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  textfieldcontroller: _firstnamecontroller,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Last name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    cursorHeight: 25,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    controller: _lastnamecontroller,
                    decoration: InputDecoration(
                      fillColor: Colors.blueGrey[100],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Nationality',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(children: [
                  ///Adding CSC Picker Widget in app
                  CSCPicker(
                    ///Enable disable state dropdown [OPTIONAL PARAMETER]
                    showStates: true,

                    /// Enable disable city drop down [OPTIONAL PARAMETER]
                    showCities: true,

                    ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                    flagState: CountryFlag.ENABLE,

                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                    dropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(10)),
                        color: Colors.blueGrey[100],
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.shade300,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///placeholders for dropdown search field
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",

                    ///labels for dropdown
                    countryDropdownLabel: "Country",
                    stateDropdownLabel: "State",
                    cityDropdownLabel: "City",

                    selectedItemStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),

                    ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                    dropdownHeadingStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),

                    ///DropdownDialog Item style [OPTIONAL PARAMETER]
                    dropdownItemStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),

                    ///Dialog box radius [OPTIONAL PARAMETER]
                    dropdownDialogRadius: 10.0,

                    ///Search bar radius [OPTIONAL PARAMETER]
                    searchBarRadius: 10.0,

                    ///triggers once country selected in dropdown
                    onCountryChanged: (value) {
                      setState(() {
                        ///store value in country variable
                        countryValue = value;
                      });
                    },

                    ///triggers once state selected in dropdown
                    onStateChanged: (value) {
                      setState(() {
                        ///store value in state variable
                        stateValue = value;
                      });
                    },

                    ///triggers once city selected in dropdown
                    onCityChanged: (value) {
                      setState(() {
                        ///store value in city variable
                        cityValue = value;
                      });
                    },
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Date of birth ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  autofocus: true,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 50),
                    primary: Colors.blueGrey[100],
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side:
                          const BorderSide(color: Colors.transparent, width: 2),
                    ),
                  ),
                  child: Container(
                    child: Row(children: [
                      Text(
                        isDateselected
                            ? 'No Date Chosen!'
                            : DateFormat.yMMMMEEEEd()
                                .format(selectedDate)
                                .toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      )
                    ]),
                  ),
                  onPressed: () {
                    showDatePicker();
                    print(selectedDate);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (isDateselected = true) {
                            print('good');

                            _createdoc(
                                _firstnamecontroller.text,
                                _lastnamecontroller.text,
                                // DateFormat.yMMMMEEEEd()
                                //     .format(selectedDate)
                                //     .toString(),
                                countryValue,
                                stateValue,
                                cityValue,
                                autth.auth.currentUser!.email);
                            Navigator.pushNamed(context, '/home');
                          }
                        } else {
                          print('bad');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 50),
                        primary: Colors.blueGrey,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Continue ',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )),
              ]);
        }));
  }
}
