import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'intro');
                      },
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blueGrey[100],
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.blueGrey,
                            size: 40,
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Log - in',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Your Email',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              emailtextfield_widg(
                                  emailcontroller: logi.emailController,
                                  validator: logi.emailValidator),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Password',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
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
                              const SizedBox(
                                height: 10,
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
                                  Navigator.pushNamed(context, '/home');
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
                                Navigator.pushNamed(context, '/home');
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
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/reset'),
                      child: const Text(
                        ' Reset Password?',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                    )),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Dont have an account?',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign Up',
                                  style: const TextStyle(
                                      color: Colors.blueGrey, fontSize: 18),
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
          child: const Text(
            "OK",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
