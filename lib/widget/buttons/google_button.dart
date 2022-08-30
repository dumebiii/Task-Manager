import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleSign extends StatelessWidget {
  const GoogleSign({Key? key, this.todo}) : super(key: key);

  final VoidCallback? todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(0.w, 50.h),
            primary: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
              side: BorderSide(color: Colors.blueGrey, width: 2.w),
            ),
          ),
          onPressed: todo,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage("assets/images/google_logo.png"),
                  height: 35.0.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
