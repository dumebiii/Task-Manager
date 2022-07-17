// ignore_for_file: unused_import

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:wow/buisness_logic/view_model/notesoperation.dart';
import 'package:wow/screen/account_screen.dart';
import 'package:wow/screen/buisness.dart';
import 'package:wow/screen/home_screen.dart';
import 'package:wow/screen/introScreen.dart';
import 'package:wow/screen/menuPage.dart';
import 'package:wow/screen/personal_screen.dart';
import 'package:wow/screen/signIn.dart';
import 'package:wow/screen/signUp.dart';
import 'package:wow/screen/user_info.dart';
import 'package:wow/screen/verifyEmail.dart';
import 'package:wow/service/checkConnect.dart';
import 'package:wow/service/internetCheck.dart';
import 'package:wow/service/service_locator.dart';
import 'package:wow/service/connection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screen/passwordReset.dart';
import 'service/firebase_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await setUpserviceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<NotesOpertaion>(
            create: (context) => NotesOpertaion(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          )
        ],
        child: ScreenUtilInit(
          splitScreenMode: false,
          minTextAdapt: true,
          designSize: const Size(375, 812),
          builder: (BuildContext context, child) => MaterialApp(
            theme: ThemeData(
              primaryColor: Colors
                  .white, //here it goes try changing this to your preferred colour
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: '/main',
            routes: {
              'intro': (context) => const LoadScreen(),
              '/login': (context) => const SignIn(),
              '/signup': (context) => const SignUp(),
              '/home': (context) => const MyHomePage(),
              '/user': (context) => const Userdd(),
              '/menu': (context) => const Menu(),
              '/personal': (context) => const Personal(),
              '/business': (context) => const Buisness(),
              '/main': (context) => const MainPage(),
              '/account': (context) => const Account(),
              '/verify': (context) => const VerifyEmail(),
              '/reset': (context) => const PasswordReset(),
            },
          ),
        ));
  }
}

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    CheckUserConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authh, child) {
      return Scaffold(
          body: ActiveConnection
              ? StreamBuilder<User?>(
                  stream: authh.onAuthStateChanged,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }
                    if (snapshot.hasData) {
                      return const MyHomePage();
                    } else {
                      return const LoadScreen();
                    }
                  })
              : Scaffold(
                  backgroundColor: Colors.blueGrey,
                  body: SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: const Icon(
                              Icons
                                  .signal_wifi_connected_no_internet_4_outlined,
                              size: 70,
                              color: Colors.blueGrey,
                            ),
                            color: Colors.white,
                          ),
                          const Text(
                            'No internet Connection',
                            style: TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  CheckUserConnection();
                                });
                              },
                              child: Text('reload'))
                        ],
                      ),
                    ),
                  ),
                ));
      // const Noconnect());
    });
  }
}

// class Noconnect extends StatefulWidget {
//   const Noconnect({Key? key}) : super(key: key);

//   @override
//   State<Noconnect> createState() => _NoconnectState();
// }

// class _NoconnectState extends State<Noconnect> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
