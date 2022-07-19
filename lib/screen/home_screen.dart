import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:wow/buisness_logic/model/note.dart';
import 'package:wow/buisness_logic/view_model/notesoperation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../buisness_logic/view_model/Homeviewmodel.dart';
import '../service/service_locator.dart';
import '../widget/reuse_widget.dart';
import 'add_screen.dart';
import 'menuPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _advancedDrawerController = AdvancedDrawerController();
  final NotesOpertaion notesOpertaion = locator<NotesOpertaion>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesOpertaion.loadDataFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
        child: Consumer<HomeViewModel>(builder: (context, homeInfo, child) {
          // return Consumer<NotesOpertaion>(builder: (context, data, child) {
          return AdvancedDrawer(
            drawer: const Menu(),
            backdropColor: Colors.blueGrey,
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            // openScale: 1.0,
            disabledGestures: false,
            childDecoration: BoxDecoration(
              // NOTICE: Uncomment if you want to add shadow behind the page.
              // Keep in mind that it may cause animation jerks.
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 0.r,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            child: WillPopScope(
              onWillPop: _onWillPop,
              child: Scaffold(
                  backgroundColor: Colors.white,
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) {
                            return const AddScreen();
                          });
                    },
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blueGrey,
                  ),
                  body: FutureBuilder(
                      future: homeInfo.fetchdetails(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                              child: Text('Loading data ... please wait'));
                        }
                        if (snapshot.hasData) {
                          dynamic dataa = snapshot.data;
                          return SafeArea(
                              child: Padding(
                            padding: EdgeInsets.only(
                                top: 50.h,
                                left: 20.w,
                                right: 20.w,
                                bottom: 0.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: _handleMenuButtonPressed,
                                      icon: ValueListenableBuilder<
                                              AdvancedDrawerValue>(
                                          valueListenable:
                                              _advancedDrawerController,
                                          builder: (_, value, __) {
                                            return AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 250),
                                              child: value.visible
                                                  ? Icon(
                                                      Icons.clear,
                                                      size: 50.r,
                                                      color: Colors.blueGrey,
                                                    )
                                                  : Icon(
                                                      Icons.dashboard_outlined,
                                                      size: 50.r,
                                                      color: Colors.blueGrey,
                                                    ),
                                            );
                                          })),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  AutoSizeText(
                                    "What's up, ${dataa['lname']}",
                                    textScaleFactor: 1.0,
                                    minFontSize: 25,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 30.sp,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Text(
                                    'CATEGORIES',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Consumer<NotesOpertaion>(
                                        builder: (context, notee, child) {
                                      return Row(
                                        children: [
                                          homeCatWidg(
                                            catText: 'Personal',
                                            text:
                                                "${notee.getPersonal().length.toString()} tasks",
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/personal');
                                            },
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          homeCatWidg(
                                            catText: 'Business',
                                            text:
                                                "${notee.getBuisness().length.toString()} tasks",
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/business');
                                            },
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  Text(
                                    'My Tasks',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Consumer<NotesOpertaion>(
                                      builder: (context, notee, child) {
                                    return Expanded(
                                      child: ListView.builder(
                                        // physics: AlwaysScrollableScrollPhysics(),

                                        shrinkWrap: true,
                                        itemBuilder: ((context, index) {
                                          return NotesCard(
                                              notes: notee.notes[index]);
                                        }),
                                        itemCount: notee.notes.length,
                                      ),
                                    );
                                  }),
                                ]),
                          ));
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Center(
                                    child: CircularProgressIndicator()),
                                signInlogInwidget(
                                    todoText: 'Sign Out ',
                                    todo: () async {
                                      await homeInfo.firebaseservice.logOut();
                                      Navigator.pushNamed(context, '/login');
                                    }),
                              ],
                            ),
                          );
                        }
                      })),
            ),
          );
          // });
        }));
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();

    _advancedDrawerController.showDrawer();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit this App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const DueText(text: 'No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: const DueText(text: 'Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}

class NotesCard extends StatelessWidget {
  final Note notes;
  const NotesCard({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isStrike = false;

    return Consumer<NotesOpertaion>(builder: (context, nott, child) {
      return GestureDetector(
        onTap: (() {
          Alert(
            context: context,
            type: AlertType.success,
            title: notes.title,
            desc: notes.description,
            buttons: [
              DialogButton(
                color: Colors.blueGrey,
                child: Text(
                  "SEEN",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120.w,
              )
            ],
          ).show();
        }),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                trailing: IconButton(
                  onPressed: () async {
                    await nott.delNewNote(notes);
                    print(notes);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
                title: Text(
                  notes.title, maxLines: 1,
                  textScaleFactor: 1.0,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,

                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                  // style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                subtitle: Text(
                  notes.description,

                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                  // minFontSize: 15,
                  textScaleFactor: 1.0,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(notes.choice,
                      // maxFontSize: 15,
                      // minFontSize: 10,
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(notes.datee,
                          // maxFontSize: 15,
                          // minFontSize: 10,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(notes.dateTime,
                          // maxFontSize: 15,
                          // minFontSize: 10,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
