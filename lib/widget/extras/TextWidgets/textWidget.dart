import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
