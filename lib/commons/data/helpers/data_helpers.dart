import 'dart:collection';

import '/commons/entities/disco.dart';

class DataHelpers {
  /// Funzione per estrarre la lista delle posizioni dei dischi
  List<String> estraiListaPosizioniDischi(List<Disco> listaDischi) {
    // Estrai tutte le posizioni non nulle e uniscile in un Set per ottenere solo valori unici
    return listaDischi
        .where((disco) =>
            disco.posizione != null) // Filtra dischi con posizione non nulla
        .map((disco) => disco.posizione!) // Mappa le posizioni
        .toSet() // Rimuove i duplicati
        .toList(); // Converte di nuovo in una lista
  }

  // Funzione per estrarre il numero dei dischi
  int estraiNumeroDischi(List<Disco> listaDischi) {
    return listaDischi.length;
  }

  /// Funzione per estrarre le statistiche dell'utente
  Map<String, int> calcolaStatisticheUtente(List<Disco> listaDischi) {
    // Insiemi per memorizzare elementi unici (album, artisti, brani)
    final Set<String?> albumSet = HashSet();
    final Set<String?> artistiSet = HashSet();
    final Set<String?> braniSet = HashSet();

    for (var disco in listaDischi) {
      // Aggiungi album e artista ai rispettivi set
      albumSet.add(disco.titoloAlbum);
      artistiSet.add(disco.artista);

      // Aggiungi brani lato A
      braniSet
        ..add(disco.brano1A)
        ..add(disco.brano2A)
        ..add(disco.brano3A)
        ..add(disco.brano4A)
        ..add(disco.brano5A)
        ..add(disco.brano6A)
        ..add(disco.brano7A)
        ..add(disco.brano8A);

      // Aggiungi brani lato B
      braniSet
        ..add(disco.brano1B)
        ..add(disco.brano2B)
        ..add(disco.brano3B)
        ..add(disco.brano4B)
        ..add(disco.brano5B)
        ..add(disco.brano6B)
        ..add(disco.brano7B)
        ..add(disco.brano8B);
    }

    // Rimuovi eventuali null dal set dei brani
    braniSet.remove(null);

    // Crea una mappa con i dati delle statistiche
    return {
      'album': albumSet.length,
      'artisti': artistiSet.length,
      'brani': braniSet.length,
    };
  }
}
