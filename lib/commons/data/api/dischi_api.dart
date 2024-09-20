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
          'titoloAlbum',
          descending: false,
        )
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

        logger.d(elemento);

        Disco disco = Disco.fromJson(elemento);

        disco.copyWith(id: id);

        // Aggiungo il disco alla lista
        lista.add(
          disco,
        );
      },
    ).toList();

    // // Fake awaiting time
    // await Future.delayed(Duration.zero);

    // // Dati di sample
    // lista = const [
    //   Disco(
    //       id: '1',
    //       artista: 'The Beatles',
    //       posizione: '1',
    //       titoloAlbum: 'Abbey Road',
    //       anno: '1969',
    //       valore: 1500.0,
    //       giri: '33'),
    //   Disco(
    //       id: '2',
    //       artista: 'Pink Floyd',
    //       posizione: '2',
    //       titoloAlbum: 'The Dark Side of the Moon',
    //       anno: '1973',
    //       valore: 2000.0,
    //       giri: '33'),
    //   Disco(
    //       id: '3',
    //       artista: 'Led Zeppelin',
    //       posizione: '3',
    //       titoloAlbum: 'Led Zeppelin IV',
    //       anno: '1971',
    //       valore: 1800.0,
    //       giri: '45'),
    //   Disco(
    //       id: '4',
    //       artista: 'David Bowie',
    //       posizione: '4',
    //       titoloAlbum: 'The Rise and Fall of Ziggy Stardust',
    //       anno: '1972',
    //       valore: 1600.0,
    //       giri: '33'),
    //   Disco(
    //       id: '5',
    //       artista: 'The Rolling Stones',
    //       posizione: '5',
    //       titoloAlbum: 'Exile on Main St.',
    //       anno: '1972',
    //       valore: 1400.0,
    //       giri: '33'),
    //   Disco(
    //       id: '6',
    //       artista: 'Queen',
    //       posizione: '6',
    //       titoloAlbum: 'A Night at the Opera',
    //       anno: '1975',
    //       valore: 1900.0,
    //       giri: '45'),
    //   Disco(
    //       id: '7',
    //       artista: 'Bob Dylan',
    //       posizione: '7',
    //       titoloAlbum: 'Highway 61 Revisited',
    //       anno: '1965',
    //       valore: 1700.0,
    //       giri: '33'),
    //   Disco(
    //       id: '8',
    //       artista: 'Fleetwood Mac',
    //       posizione: '8',
    //       titoloAlbum: 'Rumours',
    //       anno: '1977',
    //       valore: 2100.0,
    //       giri: '33'),
    //   Disco(
    //       id: '9',
    //       artista: 'Michael Jackson',
    //       posizione: '9',
    //       titoloAlbum: 'Thriller',
    //       anno: '1982',
    //       valore: 2200.0,
    //       giri: '45'),
    //   Disco(
    //       id: '10',
    //       artista: 'The Clash',
    //       posizione: '10',
    //       titoloAlbum: 'London Calling',
    //       anno: '1979',
    //       valore: 1750.0,
    //       giri: '33'),
    //   Disco(
    //       id: '11',
    //       artista: 'Prince',
    //       posizione: '11',
    //       titoloAlbum: 'Purple Rain',
    //       anno: '1984',
    //       valore: 1850.0,
    //       giri: '45'),
    //   Disco(
    //       id: '12',
    //       artista: 'Bruce Springsteen',
    //       posizione: '12',
    //       titoloAlbum: 'Born to Run',
    //       anno: '1975',
    //       valore: 1600.0,
    //       giri: '33'),
    //   Disco(
    //       id: '13',
    //       artista: 'U2',
    //       posizione: '13',
    //       titoloAlbum: 'The Joshua Tree',
    //       anno: '1987',
    //       valore: 1950.0,
    //       giri: '33'),
    //   Disco(
    //       id: '14',
    //       artista: 'Radiohead',
    //       posizione: '14',
    //       titoloAlbum: 'OK Computer',
    //       anno: '1997',
    //       valore: 2300.0,
    //       giri: '33'),
    //   Disco(
    //       id: '15',
    //       artista: 'The Doors',
    //       posizione: '15',
    //       titoloAlbum: 'The Doors',
    //       anno: '1967',
    //       valore: 1550.0,
    //       giri: '78'),
    //   Disco(
    //       id: '16',
    //       artista: 'The Velvet Underground',
    //       posizione: '16',
    //       titoloAlbum: 'The Velvet Underground & Nico',
    //       anno: '1967',
    //       valore: 2500.0,
    //       giri: '33'),
    //   Disco(
    //       id: '17',
    //       artista: 'Nirvana',
    //       posizione: '17',
    //       titoloAlbum: 'Nevermind',
    //       anno: '1991',
    //       valore: 2400.0,
    //       giri: '45'),
    //   Disco(
    //       id: '18',
    //       artista: 'AC/DC',
    //       posizione: '18',
    //       titoloAlbum: 'Back in Black',
    //       anno: '1980',
    //       valore: 2000.0,
    //       giri: '33'),
    //   Disco(
    //       id: '19',
    //       artista: 'Black Sabbath',
    //       posizione: '19',
    //       titoloAlbum: 'Paranoid',
    //       anno: '1970',
    //       valore: 1700.0,
    //       giri: '33'),
    //   Disco(
    //       id: '20',
    //       artista: 'The Eagles',
    //       posizione: '20',
    //       titoloAlbum: 'Hotel California',
    //       anno: '1976',
    //       valore: 2100.0,
    //       giri: '33'),
    //   Disco(
    //       id: '21',
    //       artista: 'Simon & Garfunkel',
    //       posizione: '21',
    //       titoloAlbum: 'Bridge Over Troubled Water',
    //       anno: '1970',
    //       valore: 1650.0,
    //       giri: '45'),
    //   Disco(
    //       id: '22',
    //       artista: 'The Who',
    //       posizione: '22',
    //       titoloAlbum: 'Who\'s Next',
    //       anno: '1971',
    //       valore: 1600.0,
    //       giri: '78'),
    //   Disco(
    //       id: '23',
    //       artista: 'R.E.M.',
    //       posizione: '23',
    //       titoloAlbum: 'Automatic for the People',
    //       anno: '1992',
    //       valore: 1850.0,
    //       giri: '33'),
    //   Disco(
    //       id: '24',
    //       artista: 'Jimi Hendrix',
    //       posizione: '24',
    //       titoloAlbum: 'Electric Ladyland',
    //       anno: '1968',
    //       valore: 2400.0,
    //       giri: '45'),
    //   Disco(
    //       id: '25',
    //       artista: 'The Smiths',
    //       posizione: '25',
    //       titoloAlbum: 'The Queen is Dead',
    //       anno: '1986',
    //       valore: 1950.0,
    //       giri: '33'),
    //   Disco(
    //       id: '26',
    //       artista: 'Guns N\' Roses',
    //       posizione: '26',
    //       titoloAlbum: 'Appetite for Destruction',
    //       anno: '1987',
    //       valore: 2200.0,
    //       giri: '33'),
    //   Disco(
    //       id: '27',
    //       artista: 'Oasis',
    //       posizione: '27',
    //       titoloAlbum: '(What\'s the Story) Morning Glory?',
    //       anno: '1995',
    //       valore: 2300.0,
    //       giri: '33'),
    //   Disco(
    //       id: '28',
    //       artista: 'Metallica',
    //       posizione: '28',
    //       titoloAlbum: 'Metallica (The Black Album)',
    //       anno: '1991',
    //       valore: 2100.0,
    //       giri: '78'),
    //   Disco(
    //       id: '29',
    //       artista: 'Pearl Jam',
    //       posizione: '29',
    //       titoloAlbum: 'Ten',
    //       anno: '1991',
    //       valore: 2000.0,
    //       giri: '33'),
    //   Disco(
    //       id: '30',
    //       artista: 'The Strokes',
    //       posizione: '30',
    //       titoloAlbum: 'Is This It',
    //       anno: '2001',
    //       valore: 1800.0,
    //       giri: '33'),
    // ];

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
