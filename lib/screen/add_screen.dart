// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:wow/buisness_logic/view_model/notesoperation.dart';

import 'package:intl/intl.dart';
import 'package:wow/widget/reuse_widget.dart';

import '../buisness_logic/view_model/addViewModel.dart';
import '../service/service_locator.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final NotesOpertaion notesOpertaion = locator<NotesOpertaion>();

  void initState() {
    // TODO: implement initState
    super.initState();
    notesOpertaion.loadDataFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddViewModel>(
        create: (context) => AddViewModel(),
        child: Consumer<AddViewModel>(builder: (context, adv, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Center(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                'Add task',
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(children: [
                                  straightField(
                                    textfieldValidator: adv.textValidator,
                                    textfieldcontroller: adv.titleController,
                                    hintText: 'enter task title',
                                    onCHange: (value) {
                                      adv.titleText = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  straightField(
                                      textfieldValidator: adv.textValidator,
                                      textfieldcontroller:
                                          adv.descriptionController,
                                      hintText: "enter task description",
                                      onCHange: (value) {
                                        adv.descriptionText = value;
                                      }),
                                  Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const DueText(
                                          text: 'Category',
                                        ),
                                        DropdownButton(
                                          dropdownColor: Colors.blueGrey,
                                          // Initial Value
                                          value: adv.dropdownvalue,

                                          // Down Arrow Icon
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),

                                          // Array list of items
                                          items: adv.items.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (newValue) {
                                            setState(() {
                                              adv.dropdownvalue =
                                                  newValue as String;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const DueText(
                                          text: "Due date",
                                        ),
                                        SizedBox(width: 10.w),
                                        Duegesture(
                                          onTap: () {
                                            showDatePicker(adv);
                                          },
                                          child: adv.selectedDate == null
                                              ? AutoSizeText(
                                                  DateFormat.yMMMd()

                                                      // displaying formatted date
                                                      .format(DateTime.now()),
                                                  minFontSize: 15,
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontSize: 19.sp),
                                                )
                                              : AutoSizeText(
                                                  DateFormat.yMMMd()

                                                      // displaying formatted date
                                                      .format(adv.selectedDate)
                                                      .toString(),
                                                  minFontSize: 15,
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontSize: 19.sp),
                                                ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const DueText(
                                          text: 'Due time',
                                        ),
                                        SizedBox(width: 10.w),
                                        Duegesture(
                                          child:
                                              // ? Text(
                                              //     DateFormat.MMMMEEEEd()

                                              //         // displaying formatted date
                                              //         .format(DateTime
                                              //             .now()),
                                              AutoSizeText(
                                            adv.dateTimee(),
                                            textScaleFactor: 1.0,
                                            minFontSize: 15,
                                            style: TextStyle(fontSize: 19.sp),
                                          ),
                                          onTap: () {
                                            adv.selectTime(context);
                                          },
                                        )
                                      ],
                                    ),
                                  ])
                                ]),
                              ),
                              Consumer<NotesOpertaion>(
                                  builder: (context, nott, child) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0.w),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 2,
                                          primary: Colors.blueGrey),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            nott.addNewNote(
                                                adv.titleController.text,
                                                adv.descriptionController.text,
                                                adv.datE(),
                                                adv.dateTimee(),
                                                adv.dropdownvalue);

                                            await adv.saveUsertask();

                                            Navigator.pop(context);
                                          } catch (e) {
                                            print(e);
                                          }
                                        }
                                        ;
                                      },
                                      child: Center(
                                        child: Text(
                                          'add',
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                      )),
                                );
                              }),
                            ],
                          )))));
        }));
  }

  void showDatePicker(AddViewModel adv) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: 220.h,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != adv.selectedDate) {
                  setState(() {
                    adv.selectedDate = value;
                  });
                }
              },
              initialDateTime: adv.selectedDate,
              minimumYear: DateTime.now().year,
              maximumYear: 4050,
            ),
          );
        });
  }
}
