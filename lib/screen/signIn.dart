import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wow/screen/home_screen.dart';
import 'package:wow/utils/error_codes.dart';

import '../buisness_logic/view_model/loginViewmodel.dart';
import '../service/service_locator.dart';
import '../widget/reuse_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final LoginViewModel logi = locator<LoginViewModel>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    logi.emailController.dispose();
    logi.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
        create: (context) => logi,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                      height: 40.h,
                    ),
                    Text(
                      'Log - in',
                      style: TextStyle(
                          fontSize: 40.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Your Email',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              emailtextfield_widg(
                                  emailcontroller: logi.emailController,
                                  validator: logi.emailValidator),
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
                                height: 10.sp,
                              ),
                              passtextfieldWidget(
                                  sufixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        logi.passwordVisible =
                                            !logi.passwordVisible;
                                      });
                                    },
                                    child: logi.passwordVisible
                                        ? Image.asset(
                                            'assets/images/eye.png',
                                          )
                                        : Image.asset('assets/images/eyec.png'),
                                  ),
                                  passwordvalidator: logi.passwordValidator,
                                  passwordVisible: logi.passwordVisible,
                                  passwordcontroller: logi.passwordController),
                              SizedBox(
                                height: 10.h,
                              ),
                            ])),
                    Consumer<LoginViewModel>(builder: (context, logi, child) {
                      return Column(
                        children: [
                          signInlogInwidget(
                            todoText: 'Log in',
                            todo: () async {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const Center(
                                        child: CircularProgressIndicator()));
                                try {
                                  // ignore: unrelated_type_equality_checks
                                  await logi.login();
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (BuildContext context) =>
                                  //             const MyHomePage()));
                                  final _user = await logi.fetchdetails();
                                  if (_user == null) {
                                    Navigator.pushReplacementNamed(
                                        context, '/user');
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const MyHomePage()));
                                  }
                                } on FirebaseAuthException catch (e) {
                                  Navigator.pop(context);
                                  var message = e.message;

                                  return _showalertdialog(message!);
                                }
                              }
                            },
                          ),
                          googlesignWidget(todo: () async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                    child: CircularProgressIndicator()));
                            try {
                              await logi.gregister();
                              final _user = await logi.fetchdetails();
                              if (_user == null) {
                                Navigator.pushNamed(context, '/user');
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const MyHomePage()));
                              }
                            } on FirebaseAuthException catch (e) {
                              Navigator.pop(context);
                              var message = e.message;
                              return _showalertdialog(message!);
                            }
                          }),
                        ],
                      );
                    }),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/reset'),
                      child: Text(
                        ' Reset Password?',
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 19.sp),
                      ),
                    )),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Dont have an account?',
                            style:
                                TextStyle(color: Colors.black, fontSize: 19.sp),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign Up',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 19.sp),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/signup');
                                    })
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            )),
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
