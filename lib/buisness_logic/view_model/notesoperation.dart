import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:wow/buisness_logic/model/note.dart';

class NotesOpertaion extends ChangeNotifier {
  List<Note> notes = [];

  List<Note> get getNotes {
    return notes;
  }

  // ignore: non_constant_identifier_names
  // NotesOperation() {
  //   addNewNote('First Note', 'First Note Description, '');
  // }

  void addNewNote(String title, String description, String datee,
      String dateTime, String choice) {
    //Note object
    Note note = Note(title, description, datee, dateTime, choice);
    notes.add(note);
    notifyListeners();
  }

  void delNewNote(note) {
    notes.remove(note);
    notifyListeners();
  }

  List<Note> getPersonal() {
    List<Note> personal = notes
        .where((userChoice) => userChoice.choice.contains('Personal'))
        .toList();
    return personal;
  }

  List<Note> getBuisness() {
    List<Note> buisness = notes
        .where((userChoice) => userChoice.choice.contains('Business'))
        .toList();
    return buisness;
  }
}
