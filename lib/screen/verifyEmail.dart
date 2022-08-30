import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wow/utils/ui_helpers.dart';

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
    user = _firebaseservice.auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 30.h),
          child: AutoSizeText(
            'An verification mail 📩 has been sent to ${user!.email} please verify.',
            minFontSize: 20,
            style: TextStyle(color: kBluegrey, fontSize: 25.sp),
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
      Navigator.pushReplacementNamed(context, '/user');
    }
  }

// User? user = FirebaseAuth.instance.currentUser;

//   await user.sendEmailVerification();
}
