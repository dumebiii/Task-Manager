import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wow/widget/TextFormField/baseTextFormField.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {Key? key, required this.textfieldcontroller, this.textfieldValidator})
      : super(key: key);

  final TextEditingController textfieldcontroller;
  final String? Function(String?)? textfieldValidator;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField.regular(
        validator: textfieldValidator,
        cursorColor: Colors.black,
        cursorHeight: 25.h,
        keyboardType: TextInputType.text,
        autoFocus: true,
        controller: textfieldcontroller,
        decoration: InputDecoration(
          fillColor: Colors.blueGrey[100],
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0.r),
              borderSide: BorderSide.none),
        ));
  }
}
