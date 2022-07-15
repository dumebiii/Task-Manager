import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wow/screen/home_screen.dart';

import '../service/firebase_services.dart';
import '../service/service_locator.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final AuthProvider _firebaseservice = locator<AuthProvider>();
  User? user;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    user = _firebaseservice.auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueGrey[100],
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.blueGrey,
                      size: 40,
                    )),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                'An verification mail 📩 has been sent to {user!.email} please verify.',
                style: TextStyle(color: Colors.blueGrey, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> checkEmailVerified() async {
    user = _firebaseservice.auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      Navigator.pushNamed(context, '/user');
    }
  }

// User? user = FirebaseAuth.instance.currentUser;

//   await user.sendEmailVerification();
}
