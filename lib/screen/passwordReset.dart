import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wow/buisness_logic/view_model/resertWordViewModel.dart';
import 'package:wow/widget/reuse_widget.dart';

import '../service/service_locator.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final ResetPasswordViewModel reset = locator<ResetPasswordViewModel>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    reset.emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.blueGrey[100],
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.blueGrey,
                    size: 40.r,
                  )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'A password reset mail 📩 has been sent, please check inbox and verify(check spam if mail doesn\'t appear on inbox) ',
                  minFontSize: 20,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 25.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Your Email ',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Form(
                    key: _formKey,
                    child: emailtextfield_widg(
                      emailcontroller: reset.emailController,
                      validator: reset.emailValidator,
                    )),
                signInlogInwidget(
                    todoText: 'Reset password',
                    todo: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await reset.resetPassword();
                          await Navigator.pushNamed(context, '/login');
                        } on FirebaseAuthException catch (e) {
                          Navigator.pop(context);
                          var message = e.message;

                          return _showalertdialog(message!);
                        }
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    ));
  }

  _showalertdialog(String errorMsg) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: "An error occured",
      desc: errorMsg,
      buttons: [
        DialogButton(
          color: Colors.blueGrey,
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120.w,
        )
      ],
    ).show();
  }
}
