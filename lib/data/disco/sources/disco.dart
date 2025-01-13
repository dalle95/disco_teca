import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/common/helper/errors/firebase_gestione_errori.dart';

import '/data/disco/models/disco.dart';

import '/domain/disco/entities/disco.dart';
import '/domain/foto_disco/entities/foto_disco.dart';

abstract class DischiService {
  // Per gestire i log
  final logger = sl<Logger>();

  Future<Either> getDischi(String? ordine);
  Future<Either> getDischiPerPosizione(String? posizione);
  Future<Either> getRicercaDischi(String parametro);
  Future<Either> salvaDisco(DiscoEntity disco);
  Future<Either> eliminaDisco(DiscoEntity disco);
}

class DischiApiServiceImpl extends DischiService {
  // Definisco l'istanza di FirebaseAuth e FirebaseFirestore
  final FirebaseAuth _firebaseAuth = sl<FirebaseAuth>();
  final FirebaseFirestore _firebaseFirestore = sl<FirebaseFirestore>();

  late final CollectionReference _collection;

  DischiApiServiceImpl() {
    _collection = _firebaseFirestore.collection('dischi');
  }

  // Funzione per caricare solo la prima immagine del fronte
  Future<Either> loadFirstFrontImage(String discoId) async {
    logger.d("FotoDiscoApiServiceImpl | Funzione: loadFirstFrontImage");

    try {
      // Query limitata a una sola immagine
      final snapshot = await _firebaseFirestore
          .collection('dischi/$discoId/immaginiFronte')
          .orderBy('timestamp', descending: false) // Ordina per timestamp
          .limit(1) // Limita a un solo documento
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        final image = ImageData(
          id: snapshot.docs.first.id,
          file: data['path'],
          timestamp: DateTime.parse(data['timestamp']),
        );
        return Right(image);
      } else {
        return Right(null); // Nessuna immagine trovata
      }
    } catch (e) {
      logger.e(
          'Errore durante il caricamento della prima immagine del fronte: $e');
      return Left(e);
    }
  }

// Modifica della funzione getDischi per includere l'immagine anteprima
  @override
  Future<Either> getDischi(String? ordine) async {
    logger.d("DischiApiServiceImpl | Funzione: getDischi");

    List<DiscoModel> lista = [];

    try {
      // Filtro tramite la query
      final QuerySnapshot query = await _collection
          .where(
            "userID",
            isEqualTo: _firebaseAuth.currentUser!.uid,
          )
          .orderBy(
            ordine!,
            descending: false,
          )
          .get();

      // Trasformo i risultati in una lista di Dischi
      for (final element in query.docs) {
        final Map<String, dynamic> elemento =
            element.data() as Map<String, dynamic>;
        final String id = element.reference.id;

        // Ottieni il disco
        DiscoModel disco = DiscoModel.fromJson(elemento).copyWith(id: id);

        // Ottieni la prima immagine del fronte
        final result = await loadFirstFrontImage(id);
        if (result.isRight()) {
          final ImageData? anteprima = result.getOrElse(() => null);
          disco = disco.copyWith(anteprima: anteprima?.file);
        }

        // Aggiungi il disco alla lista
        lista.add(disco);
      }

      return Right(lista);
    } on FirebaseException catch (e) {
      logger.d(
          'DischiApiServiceImpl | Funzione: getDischi | Errore: ${e.message}');
      return Left(FirebaseGestioneErrori.descrizioneErrore(e));
    }
  }

// Modifica della funzione getDischiPerPosizione per includere l'immagine anteprima
  Future<Either> getDischiPerPosizione(String? posizione) async {
    logger.d("DischiApiServiceImpl | Funzione: getDischiPerPosizione");

    List<DiscoModel> lista = [];

    try {
      // Filtro tramite la query
      final QuerySnapshot query = await _collection
          .where(
            "userID",
            isEqualTo: _firebaseAuth.currentUser!.uid,
          )
          .where(
            "posizione",
            isEqualTo: posizione,
          )
          .get();

      // Trasformo i risultati in una lista di Dischi
      for (final element in query.docs) {
        final Map<String, dynamic> elemento =
            element.data() as Map<String, dynamic>;
        final String id = element.reference.id;

        // Ottieni il disco
        DiscoModel disco = DiscoModel.fromJson(elemento).copyWith(id: id);

        // Ottieni la prima immagine del fronte
        final result = await loadFirstFrontImage(id);
        if (result.isRight()) {
          final ImageData? anteprima = result.getOrElse(() => null);
          disco = disco.copyWith(anteprima: anteprima?.file);
        }

        // Aggiungi il disco alla lista
        lista.add(disco);
      }

      return Right(lista);
    } on FirebaseException catch (e) {
      logger.d(
          'DischiApiServiceImpl | Funzione: getDischiPerPosizione | Errore: ${e.message}');
      return Left(FirebaseGestioneErrori.descrizioneErrore(e));
    }
  }

  @override
  Future<Either> getRicercaDischi(String parametro) async {
    logger.d("DischiApiServiceImpl | Funzione: getRicercaDischi");

    List<DiscoModel> lista = [];

    try {
      String lowerParam = parametro.toLowerCase();
      final List<String> campi = [
        'titoloAlbum',
        'autore',
        'anno',
        'brano1A',
        'brano2A',
        'brano3A',
        'brano4A',
        'brano5A',
        'brano6A',
        'brano7A',
        'brano8A',
        'brano1B',
        'brano2B',
        'brano3B',
        'brano4B',
        'brano5B',
        'brano6B',
        'brano7B',
        'brano8B',
      ];

      List<DocumentSnapshot> risultati = [];

      for (String campo in campi) {
        final query = await _collection
            .where(
              "userID",
              isEqualTo: _firebaseAuth.currentUser!.uid,
            )
            .where(campo, isGreaterThanOrEqualTo: lowerParam)
            .where(campo, isLessThanOrEqualTo: "$lowerParam\uf8ff")
            .get();

        risultati.addAll(query.docs);
      }

      // Rimuovere i duplicati se necessario
      risultati = risultati.toSet().toList();

      // Trasformo i risultati in una lista di Servizi
      risultati.map(
        (element) {
          // Formatto il servizio
          Map<String, dynamic> elemento =
              element.data() as Map<String, dynamic>;
          String id = element.reference.id;

          DiscoModel disco = DiscoModel.fromJson(elemento);

          disco.copyWith(id: id);

          // Aggiungo il disco alla lista
          lista.add(
            disco,
          );
        },
      ).toList();

      return Right(lista);
    } on FirebaseException catch (e) {
      logger.d('getRicercaDischi | Funzione: getDischi | Errore: ${e.message}');
      return Left(FirebaseGestioneErrori.descrizioneErrore(e));
    }
  }

  @override
  Future<Either> salvaDisco(DiscoEntity disco) async {
    logger.d("DischiApiServiceImpl | Funzione: salvaDisco");

    if (disco.id == null) {
      logger.d('Modalità: Creazione Disco');

      try {
        // Aggiorno il disco con l'userID dell'utente attivo
        disco = disco.copyWith(
          userID: _firebaseAuth.currentUser!.uid,
        );

        // Preparo i dati in formato JSON
        var data = disco.toJson();

        // Aggiungo il Disco su Firebase
        final response = await _collection.add(data);

        // Definisco il servizio
        disco = disco.copyWith(
          id: response.id,
        );
        data = disco.toJson();

        // Estraggo la reference del documento
        final reference = _collection.doc(disco.id);

        // Aggiorno l'ID del disco su Firebase
        await reference.set(data);

        return Right(disco);
      } on FirebaseException catch (e) {
        logger.d(
            'Errore => DischiApiServiceImpl | Funzione: salvaDisco (Creazione disco)');
        return Left(FirebaseGestioneErrori.descrizioneErrore(e));
      }
    } else {
      logger.d('Modalità: Aggiornamento Disco');

      try {
        // Estraggo la reference del documento
        final reference = _collection.doc(disco.id);

        // Preparo i dati in formato JSON
        final data = disco.toJson();

        // Aggiornamento dati su Firebase
        await reference.update(data);

        return Right(disco);
      } on FirebaseException catch (e) {
        logger.d('Errore => ${e.code}');
        return Left(FirebaseGestioneErrori.descrizioneErrore(e));
      }
    }
  }

  @override
  Future<Either> eliminaDisco(DiscoEntity disco) async {
    logger.d("DischiApiServiceImpl | Funzione: eliminaDisco");

    try {
      // Estraggo la reference del documento
      final reference = _collection.doc(disco.id);

      // Cancello il disco su Firebase
      await reference.delete();

      return Right(disco);
    } on FirebaseException catch (e) {
      logger.d('Errore => DischiApiServiceImpl | Funzione: eliminaDisco');
      return Left(FirebaseGestioneErrori.descrizioneErrore(e));
    }
  }
}
