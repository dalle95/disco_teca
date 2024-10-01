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
}
