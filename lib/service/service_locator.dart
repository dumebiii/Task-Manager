import 'package:get_it/get_it.dart';
import 'package:wow/buisness_logic/view_model/loginViewmodel.dart';
import 'package:wow/buisness_logic/view_model/notesoperation.dart';
import 'package:wow/buisness_logic/view_model/registerViewModel.dart';
import 'package:wow/buisness_logic/view_model/resertWordViewModel.dart';
import 'package:wow/main.dart';
import 'package:wow/service/checkConnect.dart';
import 'package:wow/service/connection.dart';
import 'package:wow/service/firebase_services.dart';
import 'package:wow/service/internetCheck.dart';

import '../buisness_logic/view_model/Homeviewmodel.dart';
import '../buisness_logic/view_model/accountViewModel.dart';
import '../buisness_logic/view_model/addViewModel.dart';
import '../buisness_logic/view_model/userinfoViewmodel.dart';

GetIt locator = GetIt.instance;

Future<void> setUpserviceLocator() async {
  locator.registerSingleton<AuthProvider>(AuthProvider());
  locator.registerSingleton<NotesOpertaion>(NotesOpertaion());
  locator.registerSingleton<ConnectivityService>(ConnectivityService());
  locator.registerSingleton<InternetProvider>(InternetProvider());

  locator.registerFactory<RegisterViewmodel>(() => RegisterViewmodel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<UserViewModel>(() => UserViewModel());
  locator.registerFactory<AddViewModel>(() => AddViewModel());
  locator.registerFactory<AccountViewModel>(() => AccountViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());

  locator
      .registerFactory<ResetPasswordViewModel>(() => ResetPasswordViewModel());
}
