import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/auth/usecases/is_logged_in.dart';
import '/domain/download_app/usescases/nuova_versione_app.dart';

import '/presentation/splash/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash()) {
    appStarted();
  }

  // Per gestire i log
  final logger = sl<Logger>();

  void appStarted() async {
    logger.d('SplashCubit | Funzione: appStarted');

    // Attesa per visualizzare lo spash screen
    await Future.delayed(const Duration(seconds: 1));

    // Controllo lo stato dell'utente (loggato o no)
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();

    if (isLoggedIn) {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        var presenzaNuovaVersioneApp =
            await sl<GetNuovaVersioneAppUseCase>().call();

        presenzaNuovaVersioneApp.fold(
          (l) {},
          (r) {
            logger.d('Nuova app presente: ${r ? 'Si' : 'No'}');

            if (r) {
              emit(DownloadNuovaVersioneApp());
            } else {
              emit(Authenticated());
            }
          },
        );
      } else {
        emit(Authenticated());
      }
    } else {
      emit(UnAuthenticated());
    }
  }
}
