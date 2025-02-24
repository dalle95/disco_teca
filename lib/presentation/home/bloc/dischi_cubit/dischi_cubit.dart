import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/disco/entities/disco.dart';
import '/domain/disco/usescases/get_dischi_per_posizione.dart';
import '/domain/disco/usescases/watch_dischi.dart';

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

class DischiCubit extends Cubit<DischiCubitState> {
  DischiCubit() : super(const DischiCubitState()) {
    logger.d("DischiCubit | Constructor");
    watchDischi();
  }

  final logger = sl<Logger>();

  // We'll keep a subscription to the stream so we can cancel it on close
  StreamSubscription<Either<Object, List<DiscoEntity>>>? _dischiSubscription;

  // 1. Watch All Discs (replaces getDischi)
  void watchDischi({String? ordine}) {
    logger.d("DischiCubit | Function: watchDischi($ordine)");

    // Mark as loading initially
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Cancel any previous subscription to avoid duplicating
    _dischiSubscription?.cancel();

    // Subscribe to the watchDischiUseCase (stream)
    _dischiSubscription = sl<WatchDischiUseCase>()
        .call(
            params: WatchDischiParamters(
      ordine: ordine,
      withImages: true,
    ))
        .listen((either) {
      either.fold(
        (error) {
          // If there's an error, we set errorMessage and stop loading
          emit(state.copyWith(
            isLoading: false,
            errorMessage: error.toString(),
            dischi: [],
            dischiFiltrati: [],
          ));
        },
        (dischi) {
          // On success, we set isLoading = false and update the lists
          emit(state.copyWith(
            isLoading: false,
            errorMessage: null,
            dischi: dischi,
            dischiFiltrati: dischi,
          ));
        },
      );
    }, onError: (error) {
      // If there's a stream-level error
      logger.e("Stream error watchDischi: $error");
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    });
  }

  void refreshDischi() {
    logger.d("DischiCubit | Function: refreshDischi");
    emit(state.copyWith(dischiFiltrati: state.dischi));
  }

  // 2. Rest of your logic remains (search, filter, etc.)
  void getRicercaDischi(String parametro) {
    logger.d("DischiCubit | Function: getRicercaDischi");

    if (!state.isLoading && state.dischi.isNotEmpty) {
      // We filter from the complete list
      List<DiscoEntity> lista = [...state.dischi];

      lista = lista.where((element) {
        // Adjusted to a simpler approach or keep your logic
        final lowerParam = parametro.toLowerCase();
        return (element.titoloAlbum ?? '').toLowerCase().contains(lowerParam) ||
            (element.artista ?? '').toLowerCase().contains(lowerParam) ||
            (element.anno ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano1A ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano2A ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano3A ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano4A ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano5A ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano6A ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano7A ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano8A ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano1B ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano2B ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano3B ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano4B ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano5B ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano6B ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano7B ?? '').toLowerCase().contains(lowerParam) ||
            (element.brano8B ?? '').toLowerCase().contains(lowerParam);
      }).toList();

      // Emit new state with filtered list
      emit(state.copyWith(dischiFiltrati: lista));
    }
  }

  void disattivaRicerca() {
    logger.d("DischiCubit | Function: disattivaRicerca");
    if (!state.isLoading && state.dischi.isNotEmpty) {
      emit(state.copyWith(dischiFiltrati: state.dischi));
    }
  }

  void ordinaDischi(String criterio) {
    logger.d("DischiCubit | Function: ordinaDischi");
    final listaOrdinataFiltrata = [...state.dischiFiltrati];
    final listaOrdinata = [...state.dischi];

    listaOrdinata.sort((a, b) => _compareDischi(a, b, criterio));
    listaOrdinataFiltrata.sort((a, b) => _compareDischi(a, b, criterio));

    emit(
      state.copyWith(
        dischi: listaOrdinata,
        dischiFiltrati: listaOrdinataFiltrata,
      ),
    );
  }

  int _compareDischi(DiscoEntity a, DiscoEntity b, String criterio) {
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
  }

  void aggiornaLista({
    required DiscoEntity disco,
    required StatoAggiornamentoLista tipologia,
  }) {
    logger.d("DischiCubit | Function: aggiornaLista");
    logger.d("Type: $tipologia");
    if (!state.isLoading && state.dischi.isNotEmpty) {
      var lista = [...state.dischi];
      final index = lista.indexWhere((element) => element.id == disco.id);

      if (tipologia == StatoAggiornamentoLista.modifica && index != -1) {
        lista[index] = disco;
      } else if (tipologia == StatoAggiornamentoLista.aggiunta) {
        lista.insert(0, disco);
      } else if (tipologia == StatoAggiornamentoLista.eliminazione &&
          index != -1) {
        lista.removeAt(index);
      }
      // Sync filtered
      emit(state.copyWith(dischi: lista, dischiFiltrati: lista));
    }
  }

  void getFiltraDischi({
    required AttributoFiltro attributo,
    required String parametro,
  }) {
    logger.d("DischiCubit | Function: getFiltraDischi");
    if (!state.isLoading && state.dischi.isNotEmpty) {
      var lista = [...state.dischi];
      if (attributo == AttributoFiltro.giri) {
        lista = lista.where((element) {
          return (element.giri ?? '').toLowerCase() == parametro.toLowerCase();
        }).toList();
      } else if (attributo == AttributoFiltro.posizione) {
        lista = lista.where((element) {
          return (element.posizione ?? '').toLowerCase() ==
              parametro.toLowerCase();
        }).toList();
        lista.sort((a, b) => (a.ordine ?? 1).compareTo(b.ordine ?? 10000));
      }
      emit(state.copyWith(dischiFiltrati: lista));
    }
  }

  Future<int> getOrdinePosizione({String? posizione}) async {
    if (posizione == null) return 1;
    final result =
        await sl<GetDischiPerPosizioneUseCase>().call(params: posizione);
    return result.fold(
      (error) => 1,
      (lista) {
        if (lista.isEmpty) return 0;
        final maxOrdine = lista
            .where((element) => element.posizione == posizione)
            .map((e) => e.ordine)
            .reduce((max, ordine) => ordine! > max! ? ordine : max);
        return maxOrdine!.toInt() + 1;
      },
    );
  }

  @override
  Future<void> close() async {
    // Cancel the subscription to avoid memory leaks
    await _dischiSubscription?.cancel();
    return super.close();
  }
}
