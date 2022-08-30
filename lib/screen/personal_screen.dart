import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wow/utils/ui_helpers.dart';

import '../buisness_logic/model/note.dart';
import '../buisness_logic/view_model/notesoperation.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
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
                    backgroundColor: kLightBluegrey,
                    child: Icon(
                      Icons.arrow_upward,
                      color: kBluegrey,
                      size: 40.r,
                    )),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Personal Tasks',
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontSize: 28.sp,
                    color: kBluegrey,
                    fontWeight: FontWeight.bold),
              ),
              Consumer<NotesOpertaion>(builder: (context, data, child) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return NotessCard(notes: data.getPersonal()[index]);
                    }),
                    itemCount: data.getPersonal().length,
                  ),
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
    // bool isStrike = false;

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
                child: Text(
                  "S E E N",
                  style: TextStyle(color: kWhite, fontSize: 20.sp),
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
            color: kBluegrey,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                trailing: IconButton(
                  onPressed: () {
                    nott.delNewNote(notes);
                  },
                  icon: const Icon(Icons.delete),
                  color: kRed,
                ),
                title: Text(
                  notes.title, maxLines: 1,
                  textScaleFactor: 1.0,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,

                  style: TextStyle(
                      color: kWhite,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                  // style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                subtitle: Text(
                  notes.description,
                  maxLines: 1,
                  textScaleFactor: 1.0,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                      color: kWhite),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(notes.choice,
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: kWhite,
                        size: 20.r,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(notes.datee,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: kWhite,
                        size: 20.r,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(notes.dateTime,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: kWhite,
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
