import 'dart:convert';

import 'package:disco_teca/commons/entities/disco.dart';
import 'package:disco_teca/commons/values/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  late final FlutterSecureStorage _prefs;

  /// Inizializzazione della classe
  Future<StorageService> init() async {
    _prefs = const FlutterSecureStorage();
    return this;
  }

  /// Funzione per salvare i dati
  Future<void> saveData({required String key, required dynamic data}) async {
    String jsonData = json.encode(data);
    await _prefs.write(key: key, value: jsonData);
  }

  /// Funzione per estrarre i dati
  dynamic getData(String key) async {
    String? jsonData = await _prefs.read(key: key);
    if (jsonData != null) {
      return json.decode(jsonData);
    }
    return null;
  }

  /// Funzione per rimuovere i dati
  Future<void> removeData({required String key}) async {
    await _prefs.delete(key: key);
  }

  /// Funzione per estrarre la lista di clienti salvata
  Future<List<Disco>> estraiListaDischi() async {
    String listaSerializzata;
    List<dynamic> listaDinamica;

    // Estrazione lista dalla cache
    listaSerializzata = (await getData("listaDischi")).toString();

    // Conversione in lista
    listaDinamica = jsonDecode(listaSerializzata);

    // Mappatura degli oggetti dinamici a oggetti di tipo Cliente
    List<Disco> listaClienti = listaDinamica.map((item) {
      return Disco.fromJson(item);
    }).toList();

    return listaClienti;
  }

  // Future<void> setBool(String key, String value) async {
  //   return await _prefs.write(key: key, value: value);
  // }

  // Future<void> setString(String key, String value) async {
  //   return await _prefs.write(key: key, value: value);
  // }

  // Future<void> remove(String key) async {
  //   return await _prefs.delete(key: key);
  // }

  // // Controllo se è la prima apertura dell'app
  // Future<bool> getDeviceFirstOpen() async {
  //   return await _prefs.read(
  //               key: AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ==
  //           "true"
  //       ? true
  //       : false;
  // }

  // Controllo se l'utente è loggato
  Future<bool> getIsLoggedIn() async {
    return await _prefs.read(key: AppConstants.STORAGE_USER_DATA) == null
        ? false
        : true;
  }

  // // Estrazione informazioni autenticazione
  // Future<User> getUserProfile() async {
  //   String? profileOffline =
  //       await _prefs.read(key: AppConstants.STORAGE_USER_DATA);

  //   if (profileOffline != null && profileOffline.isNotEmpty) {
  //     try {
  //       final Map<String, dynamic> userMap = jsonDecode(profileOffline);
  //       return User.fromJson(userMap);
  //     } catch (e) {
  //       // Gestisci l'errore di parsing JSON qui, se necessario
  //       Logger().d('Errore durante la decodifica del JSON: $e');
  //     }
  //   }
  //   return const User(); // Ritorna un oggetto User vuoto in caso di errore
  // }

  // // Estrazione del token di autenticazione
  // Future<String?> getUserToken() async {
  //   return _prefs.read(key: AppConstants.STORAGE_USER_TOKEN);
  // }
}
