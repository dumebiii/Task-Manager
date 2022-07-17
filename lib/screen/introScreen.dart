import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff607d8b),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/home.png'),
                ButtonBarSuper(
                  //  wrapType: wrapType,
                  //  wrapFit: wrapFit,
                  spacing: 2.0.r, // Horizontal spacing between buttons.
                  lineSpacing: 8.0.r, // Vertical spacing between button lines.
                  buttonHeight: 48.h,
                  buttonMinWidth: 20.w,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 60.w),
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.r)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Log In ',
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff607d8b),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 60.w),
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.r)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up ',
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff607d8b),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
