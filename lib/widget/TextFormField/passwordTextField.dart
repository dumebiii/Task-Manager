import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wow/widget/TextFormField/baseTextFormField.dart';

class passtextfieldWidget extends StatelessWidget {
  final bool passwordVisible;
  final TextEditingController passwordcontroller;
  final String? Function(String?) passwordvalidator;
  final Widget sufixIcon;
  const passtextfieldWidget(
      {Key? key,
      required this.passwordVisible,
      required this.passwordcontroller,
      required this.passwordvalidator,
      required this.sufixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField.password(
      validator: passwordvalidator,
      cursorColor: Colors.black,
      cursorHeight: 25.h,
      obscureText: passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      autoFocus: true,
      controller: passwordcontroller,
      decoration: InputDecoration(
        suffixIcon: sufixIcon,
        fillColor: Colors.blueGrey[100],
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0.r),
            borderSide: BorderSide.none),
      ),
    );
  }
}
