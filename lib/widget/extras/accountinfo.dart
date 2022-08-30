import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Accountinfo extends StatelessWidget {
  const Accountinfo({Key? key, this.userInfo, this.childd}) : super(key: key);
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
        )));
  }
}

class AccInfoText extends StatelessWidget {
  const AccInfoText({
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
