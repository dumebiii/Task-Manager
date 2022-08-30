import 'package:flutter/material.dart';

class Duegesture extends StatelessWidget {
  const Duegesture(
      {Key? key, this.hour, this.min, this.onTap, required this.child})
      : super(key: key);

  final String? hour;
  final String? min;
  final void Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Center(
          child: child,
        ));
  }
}
