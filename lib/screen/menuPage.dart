import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:wow/screen/introScreen.dart';
import 'package:wow/service/firebase_services.dart';

import '../widget/reuse_widget.dart';

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
        backgroundColor: Colors.blueGrey,
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
                          size: 50.0.r,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Account',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: 35.r,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.dashboard,
                          size: 50.0.r,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Categories',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: 35.sp,
                            color: Colors.white,
                          ),
                        )),
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/personal'),
                          child: Text(
                            'Personal',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.blueGrey,
                            ),
                          )),
                    )),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/business'),
                          child: Text(
                            'Business',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.blueGrey,
                            ),
                          )),
                    )),
                    SizedBox(
                      height: 50.h,
                    ),
                    signInlogInwidget(
                        todoText: 'Sign Out ',
                        todo: () async {
                          await authh.logOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoadScreen()));
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
