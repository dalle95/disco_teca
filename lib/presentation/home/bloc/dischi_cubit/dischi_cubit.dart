import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/disco/usescases/get_dischi.dart';
import '/domain/disco/entities/disco.dart';
import '/domain/disco/usescases/get_dischi_per_posizione.dart';

import '/presentation/home/bloc/dischi_cubit/dischi_state.dart';

enum StatoAggiornamentoLista {
  modifica,
  eliminazione,
  aggiunta,
}

enum AttributoFiltro {
  giri,
  posizione,
}

class DischiCubit extends Cubit<DischiState> {
  DischiCubit() : super(DischiLoading());

  // Per gestire i log
  final logger = sl<Logger>();

  // Funzione per estrarre tutti i dischi
  Future<void> getDischi({String? ordine}) async {
    logger.d("DischiCubit | Funzione: getDischi");

    emit(DischiLoading());
    var returnedData = await sl<GetDischiUseCase>().call(params: ordine);
    returnedData.fold(
      (error) {
        emit(DischiFailureLoad(errorMessage: error));
      },
      (data) {
        emit(DischiLoaded(dischi: data));
      },
    );
  }

  // // Funzione per estrarre i dischi in base alla ricerca
  // void getRicercaDischi() async {
  //   logger.d(searchController.text);
  //   var returnedData =
  //       await sl<GetRicercaDischiUseCase>().call(params: searchController.text);
  //   returnedData.fold(
  //     (error) {
  //       emit(DischiFailureLoad(errorMessage: error));
  //     },
  //     (data) {
  //       emit(DischiLoaded(dischi: data));
  //     },
  //   );
  // }

  // Funzione per estrarre i dischi in base alla ricerca
  void getRicercaDischi(String parametro) async {
    logger.d("DischiCubit | Funzione: getRicercaDischi");

    if (state is DischiLoaded) {
      final currentState = state as DischiLoaded;
      List<DiscoEntity> lista = [...currentState.dischi];

      lista = lista.where((element) {
        return element.titoloAlbum
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.artista
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.anno
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano1A
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano2A
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano3A
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano4A
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano5A
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano6A
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano7A
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano8A
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano1B
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano2B
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano3B
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano4B
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano5B
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano6B
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano7B
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase()) ||
            element.brano8B
                .toString()
                .toLowerCase()
                .contains(parametro.toString().toLowerCase());
      }).toList();

      // Emette un nuovo stato con la lista filtrata
      emit(DischiLoaded(dischi: lista));
    }
  }

  // Funzione per ordinare i dischi
  void ordinaDischi(String criterio) {
    logger.d("DischiCubit | Funzione: ordinaDischi");

    if (state is DischiLoaded) {
      final currentState = state as DischiLoaded;
      final listaOrdinata = [...currentState.dischi];

      // Ordinamento in base al criterio selezionato
      listaOrdinata.sort((a, b) {
        switch (criterio) {
          case 'Artista':
            return (a.artista ?? '').compareTo((b.artista ?? ''));
          case 'Titolo':
            return (a.titoloAlbum ?? '').compareTo((b.titoloAlbum ?? ''));
          case 'Anno':
            return (a.anno ?? '').compareTo((b.anno ?? ''));
          case 'Posizione':
            return (a.posizione ?? '').compareTo((b.posizione ?? ''));
          default:
            return 0;
        }
      });

      // Emette un nuovo stato con la lista ordinata
      emit(DischiLoaded(dischi: listaOrdinata));
    }
  }

  // Funzione per aggiornare la lista dei dischi quando c'è una modifica, aggiunta o eliminazione di un disco
  void aggiornaLista({
    required DiscoEntity disco,
    required StatoAggiornamentoLista tipologia,
  }) {
    logger.d("DischiCubit | Funzione: aggiornaLista");

    logger.d("Tipologia: $tipologia");

    if (state is DischiLoaded) {
      final currentState = state as DischiLoaded;
      var lista = [...currentState.dischi]; // Copia della lista corrente
      final index = lista.indexWhere((element) => element.id == disco.id);

      logger.d("Lista prima dell'aggiornamento: ${lista.length}");

      if (tipologia == StatoAggiornamentoLista.modifica && index != -1) {
        lista[index] = disco; // Aggiorna il disco nella lista
      } else if (tipologia == StatoAggiornamentoLista.aggiunta) {
        lista.insert(0, disco); // Aggiungi il nuovo disco
      } else if (tipologia == StatoAggiornamentoLista.eliminazione &&
          index != -1) {
        lista.removeAt(index); // Rimuovi il disco esistente
      }

      logger.d("Lista dopo l'aggiornamento: ${lista.length}");
      emit(DischiLoaded(dischi: lista)); // Emetti il nuovo stato aggiornato
    }
  }

  // Funzione per estrarre i dischi in base al filtro (Giri o Posizione)
  void getFiltraDischi({
    required AttributoFiltro attributo,
    required String parametro,
  }) async {
    logger.d("DischiCubit | Funzione: getFiltraDischi");

    if (state is DischiLoaded) {
      final currentState = state as DischiLoaded;
      List<DiscoEntity> lista = [...currentState.dischi];

      // Filtro la lista per i giri scelti
      if (attributo == AttributoFiltro.giri) {
        lista = lista.where((element) {
          return element.giri
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase());
        }).toList();
      }
      // Filtro la lista per la posizione scelta
      if (attributo == AttributoFiltro.posizione) {
        lista = lista.where((element) {
          return element.posizione
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase());
        }).toList();

        lista.sort(
          (a, b) => (a.ordine ?? 1).compareTo(b.ordine ?? 10000),
        );
      }

      // Emette un nuovo stato con la lista filtrata
      emit(DischiLoaded(dischi: lista));
    }
  }

  Future<int> getOrdinePosizione({String? posizione}) async {
    if (posizione == null) return 1;
    var returnedData =
        await sl<GetDischiPerPosizioneUseCase>().call(params: posizione);
    return returnedData.fold(
      (error) {
        return 1;
      },
      (lista) {
        return lista.isEmpty
            ? 0
            : lista
                    .where(
                      (element) => element.posizione == posizione,
                    )
                    .map((e) => e.ordine)
                    .reduce(
                      (max, ordine) => ordine! > max! ? ordine : max,
                    )!
                    .toInt() +
                1;
      },
    );
  }
}
