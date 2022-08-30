import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignLog extends StatelessWidget {
  const SignLog({Key? key, required this.todoText, this.todo})
      : super(key: key);

  final String todoText;
  final VoidCallback? todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0.r),
        child: ElevatedButton(
          onPressed: todo,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(0.w, 50.h),
            primary: Colors.blueGrey,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: Center(
            child: Text(
              todoText,
              textScaleFactor: 1.0,
              style: TextStyle(color: Colors.white, fontSize: 25.sp),
            ),
          ),
        ));
  }
}
