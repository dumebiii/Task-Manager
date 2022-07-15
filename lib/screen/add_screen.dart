// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wow/buisness_logic/view_model/notesoperation.dart';

import 'package:intl/intl.dart';
import 'package:wow/widget/reuse_widget.dart';

import '../buisness_logic/view_model/addViewModel.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddViewModel>(
        create: (context) => AddViewModel(),
        child: Consumer<AddViewModel>(builder: (context, adv, child) {
          return Scaffold(
              body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Center(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text(
                                'Add task',
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(children: [
                                  straightField(
                                    textfieldValidator: adv.textValidator,
                                    textfieldcontroller: adv.titleController,
                                    hintText: 'enter task title',
                                    onCHange: (value) {
                                      adv.titleText = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  straightField(
                                      textfieldValidator: adv.textValidator,
                                      textfieldcontroller:
                                          adv.descriptionController,
                                      hintText: "enter task description",
                                      onCHange: (value) {
                                        adv.descriptionText = value;
                                      }),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
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
                                              items:
                                                  adv.items.map((String items) {
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
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const DueText(
                                              text: "Due date",
                                            ),
                                            Duegesture(
                                              onTap: () {
                                                showDatePicker(adv);
                                              },
                                              child: adv.selectedDate == null
                                                  ? Text(
                                                      DateFormat.MMMMEEEEd()

                                                          // displaying formatted date
                                                          .format(
                                                              DateTime.now()),
                                                    )
                                                  : Text(
                                                      DateFormat.MMMMEEEEd()

                                                          // displaying formatted date
                                                          .format(
                                                              adv.selectedDate)
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const DueText(
                                              text: 'Due time',
                                            ),
                                            Duegesture(
                                              child:
                                                  // ? Text(
                                                  //     DateFormat.MMMMEEEEd()

                                                  //         // displaying formatted date
                                                  //         .format(DateTime
                                                  //             .now()),
                                                  Text(
                                                adv.dateTimee(),
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                              onTap: () {
                                                adv.selectTime(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ]))
                                ]),
                              ),
                              Consumer<NotesOpertaion>(
                                  builder: (context, nott, child) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
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
                                      child: const Center(
                                        child: Text(
                                          'add',
                                          style: TextStyle(fontSize: 20),
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
            height: 150,
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
              maximumYear: 2090,
            ),
          );
        });
  }
}
