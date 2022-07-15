import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:wow/service/firebase_services.dart';

import '../widget/reuse_widget.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authh, child) {
      return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 170, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                        // <-- ElevatedButton
                        onPressed: (() =>
                            Navigator.pushNamed(context, '/account')),
                        icon: const Icon(
                          Icons.person_pin,
                          size: 50.0,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Account',
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.dashboard,
                          size: 50.0,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Categories',
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        )),
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/personal'),
                          child: const Text(
                            'Personal',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.blueGrey,
                            ),
                          )),
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/business'),
                          child: const Text(
                            'Business',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.blueGrey,
                            ),
                          )),
                    )),
                    const SizedBox(
                      height: 50,
                    ),
                    signInlogInwidget(
                        todoText: 'Sign Out ',
                        todo: () async {
                          await authh.logOut();
                          Navigator.pushNamed(context, 'intro');
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
