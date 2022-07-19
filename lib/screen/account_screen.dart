// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final double scaleFactor = MediaQuery.of(context).textScaleFactor;
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
                      accinfo.fnamecontroller = TextEditingController(
                        text: data['fname'],
                      );
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 10.h),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/home');
                                      },
                                      child: CircleAvatar(
                                          radius: 30.r,
                                          backgroundColor: Colors.blueGrey[100],
                                          child: Icon(
                                            Icons.arrow_upward,
                                            color: Colors.blueGrey,
                                            size: 40.r,
                                          )),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                            Text(
                                              'Account Information',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontSize: 35.sp,
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'if any details are incorrect please click and fill in the correct details and tap save button.',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.red,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text(
                                              'First Name',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller:
                                                  accinfo.fnamecontroller,
                                              cursorColor: Colors.white,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.sp / scaleFactor,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            )),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              'Last Name',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller:
                                                  accinfo.lnamecontroller,
                                              cursorColor: Colors.white,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.sp / scaleFactor,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            )),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              'Country',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller: accinfo.countryValue,
                                              cursorColor: Colors.white,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.sp / scaleFactor,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            )),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              'State',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller: accinfo.stateValue,
                                              cursorColor: Colors.white,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.sp / scaleFactor,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            )),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              'City',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            accInfoWidget(
                                                childd: TextFormField(
                                              validator:
                                                  acccInfo.textfieldValidator,
                                              controller: accinfo.cityValue,
                                              cursorColor: Colors.white,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.sp / scaleFactor,
                                                  fontWeight: FontWeight.bold),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                            )),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            signInlogInwidget(
                                                todoText: 'SAVE',
                                                todo: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    try {
                                                      await acccInfo
                                                          .updateUserCred(
                                                        accinfo.fnamecontroller
                                                            .text,
                                                        accinfo.lnamecontroller
                                                            .text,
                                                        accinfo
                                                            .countryValue.text,
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
                                    ),
                                  ],
                                ))),
                      )

                          // ),
                          );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }));
        }));
  }
}
