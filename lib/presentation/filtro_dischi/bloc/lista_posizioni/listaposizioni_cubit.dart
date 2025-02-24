import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/disco/entities/disco.dart';
import '/domain/disco/usescases/watch_dischi.dart';

import '/presentation/filtro_dischi/bloc/lista_posizioni/listaposizioni_state.dart';

class ListaPosizioniCubit extends Cubit<ListaPosizioniState> {
  ListaPosizioniCubit() : super(const ListaPosizioniState(isLoading: true)) {
    logger.d('ListaPosizioniCubit | Constructor');
    watchListaPosizioni();
  }

  final logger = sl<Logger>();
  StreamSubscription<Either<Object, List<DiscoEntity>>>? _subscription;

  void watchListaPosizioni() {
    logger.d('ListaPosizioniCubit | Function: watchListaPosizioni');

    // Start loading
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Cancel any existing subscription
    _subscription?.cancel();

    // Subscribe to the watch use case
    _subscription = sl<WatchDischiUseCase>().call().listen((either) {
      either.fold(
        (error) {
          logger.e("Error in watchListaPosizioni: $error");
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: error.toString(),
              lista: [],
            ),
          );
        },
        (dischi) {
          final listaPosizioni = dischi
              .map((d) => d.posizione)
              .where((pos) => pos != null)
              .cast<String>()
              .toSet()
              .toList();

          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: null,
              lista: listaPosizioni,
            ),
          );
        },
      );
    }, onError: (error) {
      logger.e("Stream error: $error");
      emit(state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      ));
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
