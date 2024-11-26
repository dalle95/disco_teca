import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/disco/usescases/get_dischi.dart';
import '/domain/disco/entities/disco.dart';

import 'statistiche_state.dart';

class StatisticheCubit extends Cubit<StatisticheState> {
  StatisticheCubit() : super(StatisticheLoading());

  // Per gestire i log
  final logger = sl<Logger>();

  // Funzione per estrarre tutti i Statistiche
  Future<void> getStatistiche({String? ordine}) async {
    logger.d("StatisticheCubit | Funzione: getStatistiche");

    emit(StatisticheLoading());
    var returnedData = await sl<GetDischiUseCase>().call();
    returnedData.fold(
      (error) {
        emit(StatisticheFailureLoad(errorMessage: error));
      },
      (data) {
        final statistiche = calcolaStatisticheUtente(data);
        emit(
          StatisticheLoaded(
            nDischi: statistiche['nDischi']!,
            nAlbum: statistiche['nAlbum']!,
            nArtisti: statistiche['nArtisti']!,
            nBrani: statistiche['nBrani']!,
          ),
        );
      },
    );
  }
}

/// Funzione per estrarre le statistiche dell'utente
Map<String, int> calcolaStatisticheUtente(List<DiscoEntity> listaDischi) {
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
    'nDischi': listaDischi.length,
    'nAlbum': albumSet.length,
    'nArtisti': artistiSet.length,
    'nBrani': braniSet.length,
  };
}
