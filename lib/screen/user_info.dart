import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../buisness_logic/view_model/userinfoViewmodel.dart';
import '../service/service_locator.dart';
import '../widget/reuse_widget.dart';

class Userdd extends StatefulWidget {
  const Userdd({Key? key}) : super(key: key);

  @override
  State<Userdd> createState() => _UserddState();
}

class _UserddState extends State<Userdd> {
  final UserViewModel userInfo = locator<UserViewModel>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userInfo.fnameController.dispose();
    userInfo.lnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
        create: (context) => UserViewModel(),
        child: Consumer<UserViewModel>(builder: (context, userInfo, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, 'intro');
                              },
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blueGrey[100],
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Personal',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Information',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'First name',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomTextField(
                                        textfieldcontroller:
                                            userInfo.fnameController,
                                        textfieldValidator:
                                            userInfo.textfieldValidator,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Last name',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomTextField(
                                        textfieldcontroller:
                                            userInfo.lnameController,
                                        textfieldValidator:
                                            userInfo.textfieldValidator,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Nationality',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
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
                                          flagState: CountryFlag
                                              .SHOW_IN_DROP_DOWN_ONLY,

                                          ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                                          dropdownDecoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.blueGrey[100],
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1)),

                                          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                                          disabledDropdownDecoration:
                                              BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.grey.shade300,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1)),

                                          ///placeholders for dropdown search field
                                          countrySearchPlaceholder: "Country",
                                          stateSearchPlaceholder: "State",
                                          citySearchPlaceholder: "City",

                                          ///labels for dropdown
                                          countryDropdownLabel: "Country",
                                          stateDropdownLabel: "State",
                                          cityDropdownLabel: "City",

                                          selectedItemStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                          ),

                                          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                          dropdownHeadingStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),

                                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                          dropdownItemStyle: TextStyle(
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
                                              userInfo.countryValue = value;
                                            });
                                          },

                                          ///triggers once state selected in dropdown
                                          onStateChanged: (value) {
                                            setState(() {
                                              ///store value in state variable
                                              userInfo.stateValue = value;
                                            });
                                          },

                                          ///triggers once city selected in dropdown
                                          onCityChanged: (value) {
                                            setState(() {
                                              ///store value in city variable
                                              userInfo.cityValue = value;
                                            });
                                          },
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Date of birth ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                                color: Colors.transparent,
                                                width: 2),
                                          ),
                                        ),
                                        child: Container(
                                          child: Row(children: [
                                            Text(
                                              userInfo.isDateSelected
                                                  ? 'No Date Chosen!'
                                                  : DateFormat.yMMMMEEEEd()
                                                      .format(
                                                          userInfo.selectedDate)
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ]),
                                        ),
                                        onPressed: () {
                                          showDatePicker(userInfo);
                                          print(userInfo.selectedDate);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                await userInfo.saveUserCred();
                                                await Navigator.pushNamed(
                                                    context, '/home');
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(0, 50),
                                              primary: Colors.blueGrey,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Continue ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          )),
                                    ]))
                          ])),
                ),
              )));
        }));
  }

  void showDatePicker(UserViewModel userinfo) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != userinfo.selectedDate) {
                  setState(() {
                    userinfo.isDateSelected = false;
                    userinfo.selectedDate = value;
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
}
