class Note {
  String title;
  String description;
  String datee;
  String dateTime;
  String choice;

  Note(this.title, this.description, this.datee, this.dateTime, this.choice);
  Note.fromMap(Map map)
      : title = map['title'] as String,
        description = map['description'] as String,
        datee = map['datee'] as String,
        dateTime = map['dateTime'] as String,
        choice = map['choice'] as String;

  Map toMap() {
    return {
      'title': title,
      'description': description,
      'datee': datee,
      'dateTime': dateTime,
      'choice': choice,
    };
  }
}
