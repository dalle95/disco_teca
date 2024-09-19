//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/commons/service/storage_service.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // // Bloc.observer = MyGlobalObserver();
    // await Firebase.initializeApp(
    //     // options: DefaultFirebaseOptions.currentPlatform,
    //     );
    storageService = await StorageService().init();
  }
}
