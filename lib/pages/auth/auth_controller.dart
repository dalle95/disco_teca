import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/global.dart';

import '/commons/data/api/authentication_api.dart';
import '/commons/utils/error_util.dart';
import '/commons/widgets/flutter_toast.dart';
import '/commons/routes/routes/names.dart';
import '/commons/values/constant.dart';

import '/pages/auth/bloc/auth_blocs.dart';
import '/pages/auth/bloc/auth_events.dart';

class AuthController {
  final BuildContext context;

  const AuthController({required this.context});

  /// Funzione per gestire il login
  Future<void> gestisciAutenticazione() async {
    try {
      // Richiamo lo stato del bloc AuthBloc per leggere le credenziali
      final state = context.read<AuthBloc>().state;

      UserCredential? userCredential;

      String vista = state.vista;

      // Definisco le credenziali
      String? email = state.username;
      String? password = state.password;
      String? password2 = state.password2;

      context.read<AuthBloc>().add(LoadingEvent());

      // Controlli classici
      if (email == null && password == null) {
        // Alter di validazione
        toastInfo(msg: "Username e password devono essere compilati");
      } else if (email == null) {
        // Alter di validazione
        toastInfo(msg: "L'username deve essere compilato");
      } else if (password == null) {
        // Alter di validazione
        toastInfo(msg: "La password deve essere compilata");
      }

      // Controlli per la funzione di login
      if (vista == 'Login') {
        // Se ho username e password proseguo al login
        if (email != null && password != null) {
          // Estrazioni informazioni di autenticazione
          userCredential = await AuthenticationApi().login(
            entreredEmail: email,
            entreredPassword: password,
          );
        }
      }

      // Controlli per la funzione di registrazione
      if (vista == 'Registrazione') {
        if (password == null || password2 == null) {
          // Alter di validazione
          toastInfo(msg: "Entrambe le password devono essere compilate");
        } else if (password != password2) {
          // Alter di validazione
          toastInfo(msg: "Le password non coincidono, riprovare");
        } else {
          // Estrazioni informazioni di autenticazione
          userCredential = await AuthenticationApi().registrazione(
            entreredEmail: email,
            entreredPassword: password,
          );
        }
      }

      // Se ho delle credenziali le salvo
      if (userCredential != null) {
        saveCredential(
          email: email!,
          password: password!,
          uid: userCredential.user!.uid,
        );
      }
    } on FirebaseAuthException catch (e) {
      // Gestione errore codificati di Firebase

      if (e.code == 'weak-password') {
        Logger().d('La password è troppo corta, usa almeno 6 caratteri.');
        toastInfo(msg: "La password è troppo corta, usa almeno 6 caratteri.");
      }
      if (e.code == 'invalid-credential') {
        Logger().d('Le credenziali non sono corrette. Riprova.');
        toastInfo(msg: "Le credenziali non sono corrette. Riprova.");
      } else if (e.code == 'invalid-email') {
        Logger().d("L'email non è in formato corretto");
        toastInfo(msg: "L'email non è in formato corretto");
      }
    } on CustomHttpException catch (e) {
      // Alter di validazione
      toastInfo(msg: e.message);
    } catch (e) {
      Logger().d(e.toString());

      // Alter di validazione
      toastInfo(msg: e.toString());
      rethrow;
    }
  }

  /// Funzione per effettuare il logout
  Future<void> logout() async {
    // Disconnessione utente da Firebase
    AuthenticationApi().logout();

    // Per eliminare lo stato del AuthBloc
    context.read<AuthBloc>().add(const UsernameEvent(null));
    context.read<AuthBloc>().add(const PasswordEvent(null));

    // Per rimuover i dati di autenticazione salvati sul dispositivo
    Global.storageService.removeData(key: AppConstants.STORAGE_USER_DATA);

    // Per tornare alla pagina di autenticazione
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.AUTHENTICATION, (route) => false);
  }

  // Funzione: salvataggio credenziali
  Future<void> saveCredential({
    required String email,
    required String password,
    required String uid,
  }) async {
    Logger().d("Funzione: saveCredential");
    var storage = Global.storageService;

    DateTime refreshDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    final userData = json.encode(
      {
        'uid': uid,
        'email': email,
        'password': password,
        'expiryDate': refreshDate.toIso8601String(),
      },
    );

    Logger().d(userData);

    try {
      // Salvo i dati di autenticazione
      await storage.saveData(
        key: AppConstants.STORAGE_USER_DATA,
        data: userData,
      );
    } catch (error) {
      rethrow;
    }

    Logger().d('Credenziali salvate');

    // Controllo se il context è presente e lancio la nuova pagina
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.HOME_PAGE,
        (route) => false,
      );
    }
  }
}
