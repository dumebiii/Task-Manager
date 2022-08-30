import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wow/widget/TextFormField/baseTextFormField.dart';

class emailtextfield_widg extends StatelessWidget {
  final TextEditingController emailcontroller;
  final String? Function(String?) validator;
  const emailtextfield_widg(
      {Key? key, required this.emailcontroller, required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField.regular(
        validator: validator,
        cursorColor: Colors.black,
        cursorHeight: 25.h,
        keyboardType: TextInputType.emailAddress,
        autoFocus: true,
        controller: emailcontroller,
        decoration: InputDecoration(
          fillColor: Colors.blueGrey[100],
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide.none),
        ));
  }
}
