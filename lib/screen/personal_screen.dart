import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueGrey[100],
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.blueGrey,
                      size: 40,
                    )),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Personal Tasks',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold),
              ),
              Consumer<NotesOpertaion>(builder: (context, data, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return NotessCard(notes: data.getPersonal()[index]);
                  }),
                  itemCount: data.getPersonal().length,
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
                title: GestureDetector(
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
                  child: Text(
                    notes.title, maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,

                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
