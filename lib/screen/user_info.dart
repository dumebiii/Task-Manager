import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wow/utils/ui_helpers.dart';

import '../buisness_logic/view_model/userinfoViewmodel.dart';
import '../service/service_locator.dart';
import '../widget/TextFormField/custom_field.dart';

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
              backgroundColor: kWhite,
              body: SingleChildScrollView(
                  child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, 'intro');
                              },
                              child: CircleAvatar(
                                  radius: 30.r,
                                  backgroundColor: kLightBluegrey,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: kBluegrey,
                                    size: 40.r,
                                  )),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Personal',
                              style: TextStyle(
                                  fontSize: 40.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Information',
                              style: TextStyle(
                                  fontSize: 40.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'First name',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomField(
                                        textfieldcontroller:
                                            userInfo.fnameController,
                                        textfieldValidator:
                                            userInfo.textfieldValidator,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        'Last name',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomField(
                                        textfieldcontroller:
                                            userInfo.lnameController,
                                        textfieldValidator:
                                            userInfo.textfieldValidator,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        'Nationality',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
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
                                                  Radius.circular(10.r)),
                                              color: kLightBluegrey,
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1.w)),

                                          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                                          disabledDropdownDecoration:
                                              BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.r)),
                                                  color: Colors.grey.shade300,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1.w)),

                                          ///placeholders for dropdown search field
                                          countrySearchPlaceholder: "Country",
                                          stateSearchPlaceholder: "State",
                                          citySearchPlaceholder: "City",

                                          ///labels for dropdown
                                          countryDropdownLabel: "Country",
                                          stateDropdownLabel: "State",
                                          cityDropdownLabel: "City",

                                          selectedItemStyle: TextStyle(
                                            color: kBlack,
                                            fontSize: 19.sp,
                                          ),

                                          ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                          dropdownHeadingStyle: TextStyle(
                                              color: kBlack,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold),

                                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                          dropdownItemStyle: TextStyle(
                                            color: kBlack,
                                            fontSize: 14.sp,
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
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        'Date of birth ',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ElevatedButton(
                                        autofocus: true,
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(0.w, 50.h),
                                          primary: kLightBluegrey,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            side: BorderSide(
                                                color: kTransparent,
                                                width: 2.w),
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
                                                  color: kBlack,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ]),
                                        ),
                                        onPressed: () {
                                          showDatePicker(userInfo);
                                          debugPrint(
                                              userInfo.selectedDate.toString());
                                        },
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(8.0.r),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                await userInfo.saveUserCred();
                                                await Navigator
                                                    .pushReplacementNamed(
                                                        context, '/home');
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(0.w, 50.h),
                                              primary: kBluegrey,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Continue ',
                                                style: TextStyle(
                                                    color: kWhite,
                                                    fontSize: 20.sp),
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
            height: MediaQuery.of(context).copyWith().size.height * 0.25.h,
            color: kWhite,
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
              maximumYear: DateTime.now().year,
            ),
          );
        });
  }
}
