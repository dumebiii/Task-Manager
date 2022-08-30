// ignore: file_names
import 'package:flutter/material.dart';

import '../../service/firebase_services.dart';
import '../../service/service_locator.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthProvider firebaseservice = locator<AuthProvider>();

  Future fetchdetails() async {
    var collection = firebaseservice.store.collection('Usser');
    //userUid is the current auth user
    final user = firebaseservice.auth.currentUser;

    var docSnapshot = await collection.doc(user?.uid).get();

    Map<String, dynamic>? data = docSnapshot.data();

    return data;
  }
}
