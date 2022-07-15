import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff607d8b),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/home.png'),
                ButtonBarSuper(
                  //  wrapType: wrapType,
                  //  wrapFit: wrapFit,
                  spacing: 2.0, // Horizontal spacing between buttons.
                  lineSpacing: 10.0, // Vertical spacing between button lines.
                  buttonHeight: 48,
                  buttonMinWidth: 20,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Log In ',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff607d8b),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: const Text(
                            'Sign Up ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff607d8b),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
