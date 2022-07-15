// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wow/widget/reuse_widget.dart';

import '../buisness_logic/view_model/Homeviewmodel.dart';
import '../buisness_logic/view_model/accountViewModel.dart';
import '../service/service_locator.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final HomeViewModel homeViewModel = locator<HomeViewModel>();
  final AccountViewModel accinfo = locator<AccountViewModel>();

  @override
  void dispose() {
    // TODO: implement dispose
    accinfo.fnamecontroller.dispose();
    accinfo.lnamecontroller.dispose();
    accinfo.cityValue.dispose();
    accinfo.countryValue.dispose();
    accinfo.stateValue.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountViewModel>(
        create: (context) => AccountViewModel(),
        child: Consumer<AccountViewModel>(builder: (context, acccInfo, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: FutureBuilder(
                  future: homeViewModel.fetchdetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      dynamic data = snapshot.data;
                      print(data);

                      // userInfo: data['fname'],
                      accinfo.fnamecontroller =
                          TextEditingController(text: data['fname']);
                      accinfo.lnamecontroller =
                          TextEditingController(text: data['lname']);
                      // ignore: non_constant_identifier_names
                      accinfo.countryValue =
                          TextEditingController(text: data['country']);
                      // ignore: non_constant_identifier_names
                      accinfo.cityValue =
                          TextEditingController(text: data['city']);
                      // ignore: non_constant_identifier_names
                      accinfo.stateValue =
                          TextEditingController(text: data['state']);

                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/home');
                                          },
                                          child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.blueGrey[100],
                                              child: const Icon(
                                                Icons.arrow_upward,
                                                color: Colors.blueGrey,
                                                size: 40,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          'Account Information',
                                          style: TextStyle(
                                              fontSize: 35,
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'if any details are incorrect please click and fill in the correct details and tap save button.',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const accInfoText(
                                              text: 'First Name',
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller:
                                                  accinfo.fnamecontroller,
                                              cursorColor: Colors.white,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const accInfoText(
                                              text: 'Last Name',
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller:
                                                  accinfo.lnamecontroller,
                                              cursorColor: Colors.white,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const accInfoText(
                                              text: 'Country',
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller: accinfo.countryValue,
                                              cursorColor: Colors.white,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const accInfoText(
                                              text: 'State',
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller: accinfo.stateValue,
                                              cursorColor: Colors.white,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const accInfoText(
                                              text: 'City',
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller: accinfo.cityValue,
                                              cursorColor: Colors.white,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     const accInfoText(
                                        //       text: 'Date of birth',
                                        //     ),

                                        //     ElevatedButton(
                                        //       autofocus: true,
                                        //       style: ElevatedButton.styleFrom(
                                        //         minimumSize:
                                        //             const Size(250, 50),
                                        //         primary: Colors.blueGrey,
                                        //         elevation: 0,
                                        //         shape: RoundedRectangleBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(15),
                                        //           side: const BorderSide(
                                        //               color: Colors.transparent,
                                        //               width: 2),
                                        //         ),
                                        //       ),
                                        //       child: Container(
                                        //         child: Row(children: [
                                        //           Text(
                                        //             acccInfo.isDateSelected
                                        //                 ? '${data['dob']}'
                                        //                 : DateFormat
                                        //                         .yMMMMEEEEd()
                                        //                     .format(acccInfo
                                        //                         .selectedDate)
                                        //                     .toString(),
                                        //             style: const TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontSize: 20,
                                        //                 fontWeight:
                                        //                     FontWeight.bold),
                                        //           )
                                        //         ]),
                                        //       ),
                                        //       onPressed: () {
                                        //         showDatePicker(acccInfo);
                                        //         print(acccInfo.selectedDate);
                                        //       },
                                        //     ),
                                        //   ],
                                        // ),
                                        // const SizedBox(
                                        //   height: 30,
                                        // ),
                                        signInlogInwidget(
                                            todoText: 'SAVE',
                                            todo: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                try {
                                                  await acccInfo.updateUserCred(
                                                    accinfo
                                                        .fnamecontroller.text,
                                                    accinfo
                                                        .lnamecontroller.text,
                                                    accinfo.countryValue.text,
                                                    accinfo.stateValue.text,
                                                    accinfo.cityValue.text,
                                                  );
                                                  await Navigator.pushNamed(
                                                      context, '/home');
                                                } on FirebaseException catch (e) {
                                                  debugPrint('$e');
                                                }
                                              }
                                            })
                                      ]),
                                )),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }));
        }));
  }

  void showDatePicker(AccountViewModel accinfo) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != accinfo.selectedDate) {
                  setState(() {
                    accinfo.isDateSelected = false;
                    accinfo.selectedDate = value;
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
