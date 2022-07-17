import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../buisness_logic/model/note.dart';
import '../buisness_logic/view_model/notesoperation.dart';

class Buisness extends StatefulWidget {
  const Buisness({Key? key}) : super(key: key);

  @override
  State<Buisness> createState() => _BuisnessState();
}

class _BuisnessState extends State<Buisness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.blueGrey[100],
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.blueGrey,
                      size: 40.r,
                    )),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Business Tasks',
                style: TextStyle(
                    fontSize: 35.sp,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold),
              ),
              Consumer<NotesOpertaion>(builder: (context, data, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return NotessCard(notes: data.getBuisness()[index]);
                  }),
                  itemCount: data.getBuisness().length,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class NotessCard extends StatelessWidget {
  final Note notes;
  const NotessCard({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isStrike = false;

    return Consumer<NotesOpertaion>(builder: (context, nott, child) {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(15.r),
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
                title: GestureDetector(
                  onTap: (() {
                    Alert(
                      context: context,
                      type: AlertType.success,
                      title: notes.title,
                      desc: notes.description,
                      buttons: [
                        DialogButton(
                          child: Text(
                            "S E E N",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120.w,
                        )
                      ],
                    ).show();
                  }),
                  child: Text(
                    notes.title, maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,

                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                    // style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      notes.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(notes.choice,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white,
                        size: 20.r,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(notes.datee,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: Colors.white,
                        size: 20.r,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(notes.dateTime,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
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
