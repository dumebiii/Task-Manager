import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wow/buisness_logic/view_model/loginViewmodel.dart';
import 'package:wow/buisness_logic/view_model/registerViewModel.dart';
import 'package:wow/widget/reuse_widget.dart';

import '../service/service_locator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final RegisterViewmodel regist = locator<RegisterViewmodel>();
  final LoginViewModel logi = locator<LoginViewModel>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    regist.emailController.dispose();
    regist.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => regist,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.h),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'intro');
                                  },
                                  child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundColor: Colors.blueGrey[100],
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.blueGrey,
                                        size: 40.r,
                                      )),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Create',
                                  style: TextStyle(
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Account',
                                  style: TextStyle(
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Your Email',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          emailtextfield_widg(
                                            validator: regist.emailValidator,
                                            emailcontroller:
                                                regist.emailController,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            'Password',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          passtextfieldWidget(
                                              sufixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    regist.passwordVisible =
                                                        !regist.passwordVisible;
                                                  });
                                                },
                                                child: regist.passwordVisible
                                                    ? Image.asset(
                                                        'assets/images/eye.png',
                                                      )
                                                    : Image.asset(
                                                        'assets/images/eyec.png'),
                                              ),
                                              passwordvalidator:
                                                  regist.passwordValidator,
                                              passwordVisible:
                                                  regist.passwordVisible,
                                              passwordcontroller:
                                                  regist.passwordController),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ])),
                                Consumer<RegisterViewmodel>(
                                    builder: (context, regist, child) {
                                  return Column(
                                    children: [
                                      signInlogInwidget(
                                        todoText: 'Create account',
                                        todo: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) => const Center(
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator())));
                                            try {
                                              // ignore: unrelated_type_equality_checks
                                              await regist.register();

                                              Navigator.pushNamed(
                                                  context, '/verify');
                                            } on FirebaseAuthException catch (e) {
                                              Navigator.pop(context);
                                              var message = e.message;
                                              return _showalertdialog(message!);
                                            }
                                          }
                                        },
                                      ),
                                      googlesignWidget(
                                        // todo: (() => regist.gregister()),
                                        todo: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) => const Center(
                                                  child:
                                                      CircularProgressIndicator()));
                                          try {
                                            await logi.gregister();
                                            final _user =
                                                await logi.fetchdetails();
                                            if (_user == null) {
                                              Navigator.pushNamed(
                                                  context, '/user');
                                            } else {
                                              Navigator.pushNamed(
                                                  context, '/home');
                                            }
                                            // await Navigator.pushNamed(
                                            //     context, '/user');
                                          } on FirebaseAuthException catch (e) {
                                            Navigator.pop(context);
                                            var message = e.message;
                                            return _showalertdialog(message!);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                }),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Already have an account?',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: ' Log In',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 18.sp),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.pushNamed(
                                                      context, '/login');
                                                })
                                        ]),
                                  ),
                                )
                              ]),
                        ))))));
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
