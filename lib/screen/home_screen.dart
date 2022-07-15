import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import 'package:wow/buisness_logic/model/note.dart';
import 'package:wow/buisness_logic/view_model/notesoperation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../buisness_logic/view_model/Homeviewmodel.dart';
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
            childDecoration: const BoxDecoration(
              // NOTICE: Uncomment if you want to add shadow behind the page.
              // Keep in mind that it may cause animation jerks.
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Scaffold(
                backgroundColor: Colors.white,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const AddScreen();
                        });
                  },
                  child: const Icon(
                    Icons.add,
                    size: 45,
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
                        print(homeInfo.notesOpertaion);
                        return SafeArea(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              top: 50, left: 20, right: 20, bottom: 0),
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
                                                ? const Icon(
                                                    Icons.clear,
                                                    size: 50,
                                                    color: Colors.blueGrey,
                                                  )
                                                : const Icon(
                                                    Icons.dashboard_outlined,
                                                    size: 50,
                                                    color: Colors.blueGrey,
                                                  ),
                                          );
                                        })),
                                const SizedBox(
                                  height: 30,
                                ),
                                AutoSizeText(
                                  "What's up, ${dataa['lname']}",
                                  minFontSize: 20,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  'CATEGORIES',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 20,
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
                                        const SizedBox(
                                          width: 15,
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
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  'My Tasks',
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Consumer<NotesOpertaion>(
                                    builder: (context, notee, child) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      return NotesCard(
                                          notes: notee.getNotes[index]);
                                    }),
                                    itemCount: notee.getNotes.length,
                                  );
                                }),
                              ]),
                        ));
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(child: CircularProgressIndicator()),
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
          );
          // });
        }));
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();

    _advancedDrawerController.showDrawer();
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
                child: const Text(
                  "S E E N",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                trailing: IconButton(
                  onPressed: () {
                    nott.delNewNote(notes);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
                title: Text(
                  notes.title, maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,

                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  // style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                subtitle: AutoSizeText(
                  notes.description,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  minFontSize: 15,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(notes.choice,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(notes.datee,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(notes.dateTime,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
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
