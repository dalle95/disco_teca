import 'package:app_disco_teca/domain/disco/usescases/get_dischi_per_posizione.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import '/firebase_options.dart';

import '/data/auth/repositories/auth.dart';
import '/data/auth/sources/auth_api_service.dart';
import '/data/disco/repositories/disco.dart';
import '/data/disco/sources/disco.dart';
import '/data/download_app/repositories/download_app.dart';
import '/data/download_app/sources/download_app.dart';

import '/domain/auth/repositories/auth.dart';
import '/domain/disco/repositories/disco.dart';
import '/domain/download_app/repositories/download_app.dart';
import '/domain/download_app/usescases/download_app.dart';
import '/domain/download_app/usescases/nuova_versione_app.dart';

import '/domain/disco/usescases/get_dischi.dart';
import '/domain/auth/usecases/is_logged_in.dart';
import '/domain/auth/usecases/signin.dart';
import '/domain/auth/usecases/register.dart';
import '/domain/auth/usecases/logout.dart';
import '/domain/disco/usescases/get_ricerca_dischi.dart';
import '/domain/disco/usescases/salva_disco.dart';
import '/domain/disco/usescases/elimina_disco.dart';
import '/domain/auth/usecases/signin_with_google.dart';
import '/domain/auth/usecases/register_with_google.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Inizializza Firebase (da fare all'inizio della tua app)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Singleton Tecnici
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerSingleton<FirebaseRemoteConfig>(FirebaseRemoteConfig.instance);
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  sl.registerSingleton<Logger>(Logger());
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<GoogleSignIn>(GoogleSignIn());

  // Services
  sl.registerSingleton<AuthService>(AuthApiServiceImpl());
  sl.registerSingleton<DischiService>(DischiApiServiceImpl());
  sl.registerSingleton<DownloadAppService>(DownloadAppApiServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<DischiRepository>(DischiRepositoryImpl());
  sl.registerSingleton<DownloadAppRepository>(DownloadAppRepositoryImpl());

  // Usecases
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<GetDischiUseCase>(GetDischiUseCase());
  sl.registerSingleton<GetDischiPerPosizioneUseCase>(
      GetDischiPerPosizioneUseCase());
  sl.registerSingleton<GetRicercaDischiUseCase>(GetRicercaDischiUseCase());
  sl.registerSingleton<SalvaDiscoUseCase>(SalvaDiscoUseCase());
  sl.registerSingleton<EliminaDiscoUseCase>(EliminaDiscoUseCase());
  sl.registerSingleton<DownloadAppUseCase>(DownloadAppUseCase());
  sl.registerSingleton<GetNuovaVersioneAppUseCase>(
      GetNuovaVersioneAppUseCase());
  sl.registerSingleton<SigninWithGoogleUseCase>(SigninWithGoogleUseCase());
  sl.registerSingleton<RegisterWithGoogleUseCase>(RegisterWithGoogleUseCase());
}
