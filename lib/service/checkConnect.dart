import 'package:flutter/cupertino.dart';
import 'package:wow/service/connection.dart';
import 'package:wow/service/service_locator.dart';

class ConnectedYet extends ChangeNotifier {
  final _connectivityService = locator<ConnectivityService>();

  Stream<bool> checkConnectivity() async* {
    yield await _connectivityService.checkInternetConnection();
  }

  Stream get stream => checkConnectivity();
  bool connectionStatus = true;
  bool hasCalled = false;

  bool get status {
    stream.listen((event) {
      connectionStatus = event;

      debugPrint("this is $event");
      notifyListeners();
    });
    return connectionStatus;
  }
}
