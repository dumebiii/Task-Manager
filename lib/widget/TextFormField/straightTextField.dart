import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StraightField extends StatelessWidget {
  const StraightField(
      {Key? key,
      this.textfieldcontroller,
      this.textfieldValidator,
      this.onCHange,
      this.hintText})
      : super(key: key);
  final TextEditingController? textfieldcontroller;

  final String? Function(String?)? textfieldValidator;
  final void Function(String)? onCHange;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      child: TextFormField(
        validator: textfieldValidator,
        controller: textfieldcontroller,
        onChanged: onCHange,
        // onChanged: (value) {
        //   textfieldcontroller = value;
        // },
        style: TextStyle(fontSize: 20.sp),
        cursorColor: Colors.blueGrey,
        cursorHeight: 30.h,
        textAlign: TextAlign.center,

        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 20.sp),

          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.blueGrey),
          // ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}
