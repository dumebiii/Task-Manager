import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Note {
  String title;
  String description;
  String datee;
  String dateTime;
  String choice;

  Note(this.title, this.description, this.datee, this.dateTime, this.choice);
}
