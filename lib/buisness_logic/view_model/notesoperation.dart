import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/buisness_logic/model/note.dart';

import '../../utils/shared_prefence.dart';

class NotesOpertaion extends ChangeNotifier {
  List<Note> notes = [];

  UnmodifiableListView<Note> get allnotes => UnmodifiableListView(notes);

  // ignore: non_constant_identifier_names
  // NotesOperation() {
  //   addNewNote('First Note', 'First Note Description, '');
  // }

  void addNewNote(String title, String description, String datee,
      String dateTime, String choice) {
    //Note object
    Note note = Note(title, description, datee, dateTime, choice);
    notes.add(note);
    saveDataToLocalStorage();
    notifyListeners();
  }

  delNewNote(note) {
    // notes.remove(note);
    notes.remove(note);
    updateDataToLocalStorage();
    notifyListeners();
  }

  List<Note> getPersonal() {
    List<Note> personal = loadDataFromLocalStorage()
        .where((userChoice) => userChoice.choice.contains('Personal'))
        .toList();
    return personal;
  }

  List<Note> getBuisness() {
    List<Note> buisness = loadDataFromLocalStorage()
        .where((userChoice) => userChoice.choice.contains('Business'))
        .toList();
    return buisness;
  }

  // void initSharedPreferences() async {
  //   await SharedPreferencesHelper.init();
  //   // sharedPreferences = SharedPreferencesHelper.i;
  //   loadDataFromLocalStorage();
  //   notifyListeners();
  // }

  Future saveDataToLocalStorage() async {
    List<String>? nottes =
        notes.map((item) => json.encode(item.toMap())).toList();

    await SharedPreferencesHelper.setStringList('list', nottes);
  }

  List<Note> loadDataFromLocalStorage() {
    List<String>? nottes = SharedPreferencesHelper.getStringList('list');
    print(nottes);

    if (nottes != null) {
      notes = nottes.map((item) => Note.fromMap(json.decode(item))).toList();
      // print(notes);
    }
    return notes;
  }

  void updateDataToLocalStorage() async {
    await SharedPreferencesHelper.delete('list');
    await saveDataToLocalStorage();
  }
}
