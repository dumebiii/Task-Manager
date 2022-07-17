import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/buisness_logic/model/note.dart';

import '../../utils/shared_prefence.dart';

class NotesOpertaion extends ChangeNotifier {
  List<Note> notes = [];

  List<Note> get getNotes {
    return notes;
  }

  // ignore: non_constant_identifier_names
  // NotesOperation() {
  //   addNewNote('First Note', 'First Note Description, '');
  // }

  SharedPreferences? sharedPreferences;

  void addNewNote(String title, String description, String datee,
      String dateTime, String choice) {
    //Note object
    Note note = Note(title, description, datee, dateTime, choice);
    notes.add(note);
    saveDataToLocalStorage();
    notifyListeners();
  }

  void delNewNote(note) {
    notes.remove(note);
    updateDataToLocalStorage();
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

  void initSharedPreferences() async {
    await SharedPreferencesHelper.init();
    sharedPreferences = SharedPreferencesHelper.instance;
    loadDataFromLocalStorage();
    notifyListeners();
  }

  void saveDataToLocalStorage() {
    List<String>? nottes =
        notes.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences?.setStringList('list', nottes);
    List<String>? geting = sharedPreferences?.getStringList('list');
    print(geting);
  }

  void loadDataFromLocalStorage() {
    List<String>? nottes = sharedPreferences?.getStringList('list');
    if (nottes != null) {
      notes = nottes.map((item) => Note.fromMap(json.decode(item))).toList();
    }
  }

  void updateDataToLocalStorage() {
    sharedPreferences?.remove('list');
    saveDataToLocalStorage();
  }
}
