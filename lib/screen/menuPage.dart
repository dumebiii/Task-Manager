import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:wow/service/firebase_services.dart';
import 'package:wow/utils/ui_helpers.dart';
import 'package:wow/widget/buttons/signlog_button.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authh, child) {
      return Scaffold(
        backgroundColor: kBluegrey,
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 170.h, 20.w, 0.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                        // <-- ElevatedButton
                        onPressed: (() =>
                            Navigator.pushNamed(context, '/account')),
                        icon: Icon(
                          Icons.person_pin,
                          size: 40.0.r,
                          color: kWhite,
                        ),
                        label: Text(
                          'Account',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: 32.r,
                            color: kWhite,
                          ),
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.dashboard,
                          size: 40.0.r,
                          color: kWhite,
                        ),
                        label: Text(
                          'Categories',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: 32.sp,
                            color: kWhite,
                          ),
                        )),
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/personal'),
                          child: Text(
                            'Personal',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: kBluegrey,
                            ),
                          )),
                    )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/business'),
                          child: Text(
                            'Business',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: kBluegrey,
                            ),
                          )),
                    )),
                    SizedBox(
                      height: 50.h,
                    ),
                    SignLog(
                        todoText: 'Sign Out ',
                        todo: () async {
                          await authh.logOut();

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'intro', (Route<dynamic> route) => false);
                        }),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
