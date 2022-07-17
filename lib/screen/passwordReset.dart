import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                Text(
                  'Your Email ',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Form(
                    child: emailtextfield_widg(
                  emailcontroller: reset.emailController,
                  validator: reset.emailValidator,
                )),
                signInlogInwidget(
                  todoText: 'Reset password',
                  todo: () async {
                    await reset.resetPassword();
                    await Navigator.pushNamed(context, '/login');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
