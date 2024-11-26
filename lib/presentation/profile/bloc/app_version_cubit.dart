import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '/service_locator.dart';

class AppVersionCubit extends Cubit<String> {
  AppVersionCubit() : super('');

  // Per gestire i log
  final logger = sl<Logger>();

  void getVersione() async {
    logger.d('AppVersionCubit | Funzione: getVersione');
    // Recupero la versione dell'applicazione
    final infoApp = await PackageInfo.fromPlatform();
    final infoVersioneApp = '${infoApp.version}+${infoApp.buildNumber}';
    emit(infoVersioneApp);
  }
}
