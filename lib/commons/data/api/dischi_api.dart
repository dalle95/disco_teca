import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '/global.dart';

import '/commons/entities/disco.dart';
import '/commons/data/api/base.dart';

class DiscoApi extends BaseRepository {
  // Definisco l'istanza di Firebase e punto alla collezione
  final collection = FirebaseFirestore.instance.collection('dischi');

  /// Funzione per estrarre la lista dei clienti
  Future<List<Disco>> estraiDati() async {
    // Per gestire i log
    var logger = Logger();

    logger.d("Funzione: estraiDatiDischi");

    List<Disco> lista = [];

    // Filtro tramite la query
    final QuerySnapshot query = await collection
        .where(
          "userID",
          isEqualTo: user!.uid,
        )
        .orderBy(
          'autore',
          descending: false,
        )
        // .orderBy(
        //   'creatoIl',
        //   descending: false,
        // )
        // .orderBy(
        //   'creatoIl',
        //   descending: false,
        // )
        .get();

    // Trasformo i risultati in una lista di Servizi
    query.docs.map(
      (element) {
        // Formatto il servizio
        Map<String, dynamic> elemento = element.data() as Map<String, dynamic>;
        String id = element.reference.id;

        Disco disco = Disco.fromJson(elemento);

        disco.copyWith(id: id);

        // Aggiungo il disco alla lista
        lista.add(
          disco,
        );
      },
    ).toList();

    // Salvataggio lista nella cache
    await Global.storageService.saveData(
      key: "listaDischi",
      data: jsonEncode(
        lista.map((element) => element.toJson()).toList(),
      ),
    );

    return lista;
  }

  /// Funzione per creare il Disco
  Future<dynamic> creaDisco(Disco disco) async {
    Logger().d('Funzione: creaDisco');

    try {
      // Aggiorno il disco con l'userID dell'utente attivo
      disco = disco.copyWith(
        userID: user!.uid,
      );

      // Preparo i dati in formato JSON
      var data = disco.toJson();

      // Aggiungo il Disco su Firebase
      final response = await addDocumentSnapshot(collection, data);

      // Definisco il servizio
      disco = disco.copyWith(
        id: response.id,
      );

      // Aggiorno l'ID del disco su Firebase
      disco = await aggiornaDisco(disco);

      return disco;
    } catch (error) {
      throw 'Funzione: creaServizio | Errore: ${error.toString()}';
    }
  }

  /// Funzione per aggiornare il disco
  Future<dynamic> aggiornaDisco(Disco disco) async {
    logger.d('Funzione: aggiornaDisco');

    logger.d(disco.toJson());

    try {
      // Estraggo la reference del documento
      final reference = collection.doc(disco.id);

      // Preparo i dati in formato JSON
      final data = disco.toJson();

      // Aggiornamento dati su Firebase
      updateDocumentSnapshot(
        reference,
        data,
      );

      return disco;
    } catch (error) {
      throw 'Funzione: aggiornaServizio | Errore: ${error.toString()}';
    }
  }

  /// Funzione per eliminare un disco
  Future<dynamic> eliminaDisco(Disco disco) async {
    logger.d('Funzione: eliminaDisco');
    try {
      final reference = collection.doc(disco.id);

      deleteDocumentSnapshot(reference);
    } catch (error) {
      throw 'Funzione: eliminaServizio | Errore: ${error.toString()}';
    }
  }
}
