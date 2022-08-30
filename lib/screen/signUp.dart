import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wow/buisness_logic/view_model/loginViewmodel.dart';
import 'package:wow/buisness_logic/view_model/registerViewModel.dart';
import 'package:wow/utils/ui_helpers.dart';
import 'package:wow/widget/buttons/google_button.dart';
import 'package:wow/widget/buttons/signlog_button.dart';

import '../service/service_locator.dart';
import '../widget/TextFormField/emailTextField.dart';
import '../widget/TextFormField/passwordTextField.dart';
// import '../widget/TextFormField/passtextfieldWidget.dart';

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
    regist.emailController.dispose();
    regist.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => regist,
        child: Scaffold(
            backgroundColor: kWhite,
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
                                      backgroundColor: kLightBluegrey,
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: kBluegrey,
                                        size: 40.r,
                                      )),
                                ),
                                verticalSpaceSmall,
                                Text(
                                  'Create',
                                  style: kTitleTextStyle.copyWith(
                                      fontSize: 37.sp, color: kBlack),
                                ),
                                Text(
                                  'Account',
                                  style: kTitleTextStyle.copyWith(
                                      fontSize: 37.sp, color: kBlack),
                                ),
                                verticalSpaceRegular,
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
                                            style: kMediumTextStyle.copyWith(
                                                fontSize: 18.sp, color: kBlack),
                                          ),
                                          verticalSpaceSmall,
                                          emailtextfield_widg(
                                            validator: regist.emailValidator,
                                            emailcontroller:
                                                regist.emailController,
                                          ),
                                          verticalSpaceSmall,
                                          Text(
                                            'Password',
                                            style: kMediumTextStyle.copyWith(
                                                fontSize: 18.sp, color: kBlack),
                                          ),
                                          verticalSpaceSmall,
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
                                      SignLog(
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

                                              Navigator.pushReplacementNamed(
                                                  context, '/verify');
                                            } on FirebaseAuthException catch (e) {
                                              Navigator.pop(context);
                                              var message = e.message;
                                              return _showalertdialog(message!);
                                            }
                                          }
                                        },
                                      ),
                                      GoogleSign(
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
                                              Navigator.pushReplacementNamed(
                                                  context, '/user');
                                            } else {
                                              Navigator.pushReplacementNamed(
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
                                            color: kBlack, fontSize: 18.sp),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: ' Log In',
                                              style: TextStyle(
                                                  color: kBluegrey,
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
          color: kBluegrey,
          child: Text(
            "OK",
            style: TextStyle(color: kWhite, fontSize: 20.sp),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120.w,
        )
      ],
    ).show();
  }
}
