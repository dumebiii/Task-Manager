// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

///strightTxTField widget
//
// ignore: camel_case_types
class straightField extends StatelessWidget {
  const straightField(
      {Key? key,
      this.textfieldValidator,
      this.hintText,
      this.onCHange,
      this.textfieldcontroller})
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

//custom RoundedTextField
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.textfieldcontroller,
    this.textfieldValidator,
  }) : super(key: key);

  final TextEditingController textfieldcontroller;
  final String? Function(String?)? textfieldValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: textfieldValidator,
        cursorColor: Colors.black,
        cursorHeight: 25.h,
        keyboardType: TextInputType.text,
        autofocus: true,
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

//password textfield

// ignore: camel_case_types
class passtextfieldWidget extends StatelessWidget {
  const passtextfieldWidget({
    Key? key,
    required this.passwordVisible,
    required this.passwordcontroller,
    required this.passwordvalidator,
    required this.sufixIcon,
  }) : super(key: key);

  final bool passwordVisible;
  final TextEditingController passwordcontroller;
  final String? Function(String?) passwordvalidator;
  final Widget sufixIcon;
  // final VoidCallback seepassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: passwordvalidator,
      cursorColor: Colors.black,
      cursorHeight: 25.h,
      obscureText: passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      autofocus: true,
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

//email TextField

// ignore: camel_case_types
class emailtextfield_widg extends StatelessWidget {
  const emailtextfield_widg({
    Key? key,
    required this.validator,
    required this.emailcontroller,
  }) : super(key: key);

  final TextEditingController emailcontroller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        cursorColor: Colors.black,
        cursorHeight: 25.h,
        keyboardType: TextInputType.emailAddress,
        autofocus: true,
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

//googlesignIn widget

// ignore: camel_case_types
class googlesignWidget extends StatelessWidget {
  const googlesignWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

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

          // autth.googleLogin();
          // Navigator.pushNamed(context, '/login');

          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/google_logo.png"),
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

// ignore: camel_case_types
class signInlogInwidget extends StatelessWidget {
  const signInlogInwidget({Key? key, this.todo, required this.todoText})
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

// ignore: camel_case_types
class accInfoWidget extends StatelessWidget {
  const accInfoWidget({
    this.userInfo,
    Key? key,
    this.childd,
  }) : super(key: key);

  final String? userInfo;
  final Widget? childd;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(10.r)),
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: childd,
          // child: Text(userInfo,
          //     overflow: TextOverflow.ellipsis,
          //     style: const TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold)),
        )));
  }
}

// ignore: camel_case_types
class accInfoText extends StatelessWidget {
  const accInfoText({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class DueText extends StatelessWidget {
  const DueText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.0,
      style: TextStyle(
          color: Colors.blueGrey, fontSize: 21.sp, fontWeight: FontWeight.bold),
    );
  }
}

class Duegesture extends StatelessWidget {
  const Duegesture({
    Key? key,
    required this.onTap,
    required this.child,
    this.hour,
    this.min,
  }) : super(key: key);

  final String? hour;
  final String? min;
  final void Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        // onTap: () {
        //   selectTime(context);
        // },
        child: Center(
          child: child,
          // child:
          //     ? Text(
          //         DateFormat.MMMMEEEEd()

          //             // displaying formatted date
          //             .format(DateTime
          //                 .now()),
          //     Text('${hour}:${min}')),
        ));
  }
}

class homeCatWidg extends StatelessWidget {
  const homeCatWidg({
    Key? key,
    required this.text,
    required this.onTap,
    required this.catText,
  }) : super(key: key);

  final String text;
  final String catText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(20.r)),
      height: 130.h,
      width: 240.w,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.blueGrey[100],
                ),
              ),
              Text(
                catText,
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
