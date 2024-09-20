import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class AuthenticationApi {
  // Definizione FirebaseAuth
  final _firebase = FirebaseAuth.instance;

  // Funzione: Registrazione utente
  Future<UserCredential> registrazione({
    String? entreredEmail,
    String? entreredPassword,
  }) async {
    Logger().d('Funzione: singIn');

    try {
      // Creo l'utente su Firebase
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: entreredEmail!,
        password: entreredPassword!,
      );

      Logger().d(userCredentials);

      // Creazione riga di utente su database firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set(
        {
          'email': entreredEmail,
        },
      );

      return userCredentials;
    } catch (error) {
      Logger().d(error);
      rethrow;
    }
  }

  // Funzione: Login utente
  Future<UserCredential> login({
    String? entreredEmail,
    String? entreredPassword,
  }) async {
    Logger().d("Funzione: logIn");

    try {
      // Eseguo l'accesso su Firebase
      final userCredentials = await _firebase.signInWithEmailAndPassword(
        email: entreredEmail!,
        password: entreredPassword!,
      );

      Logger().d(userCredentials);

      return userCredentials;
    } catch (error) {
      Logger().d(error);
      rethrow;
    }
  }

  // Funzione: Login automatico utente
  Future<bool> autoLogin() async {
    Logger().d("Funzione: autoLogin");

    // Preparo l'istanza FlutterSecureStorage per recuperare i dati di autenticazione
    const storage = FlutterSecureStorage();

    try {
      if (!await storage.containsKey(key: 'userData')) {
        Logger().d('Nessun dato sul dispositivo');
        return false;
      }

      Logger().d('Dati trovati');

      // Estrazione dei dati
      final extractedUserData =
          json.decode(await storage.read(key: 'userData') ?? '')
              as Map<String, dynamic>;

      Logger().d(extractedUserData);

      // Recupero le informazioni principali
      final refreshDate = DateTime.parse(extractedUserData['expiryDate']);
      final email = extractedUserData['email'];
      final password = extractedUserData['password'];

      // Controllo se email e password sono valide
      if (email != null && password != null) {
        // Controllo la data di refresh del token: se non è di oggi rifaccio l'autenticazione
        if (refreshDate.toLocal() !=
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            )) {
          // Refresh del token
          await login(
            entreredEmail: email,
            entreredPassword: password,
          );
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
    return false;
  }

  // Funzione: Logout utente
  Future<void> logout() async {
    Logger().d("Funzione: logout");
    try {
      await _firebase.signOut();

      Logger().d('Logout riuscito');
    } catch (error) {
      rethrow;
    }
  }
}
