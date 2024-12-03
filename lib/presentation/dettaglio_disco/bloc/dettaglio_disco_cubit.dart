import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/disco/entities/disco.dart';
import '/domain/disco/usescases/salva_disco.dart';

import '/presentation/dettaglio_disco/bloc/ui_state/ui_state_cubit.dart';

class DettaglioDiscoCubit extends Cubit<DiscoEntity> {
  DettaglioDiscoCubit(DiscoEntity initialState) : super(initialState);

  // Per gestire i log
  final logger = sl<Logger>();

  Future<void> salvaDati(BuildContext context) async {
    logger.d('DettaglioDiscoCubit | Funzione: salvaDati');

    var data = await sl<SalvaDiscoUseCase>().call(params: state);
    data.fold(
      (error) {
        logger.d(error);
        context.read<UIStateCubit>().setError('Salvataggio fallito: $error');
      },
      (data) async {
        context.read<UIStateCubit>().setSuccess();
        emit(data);
      },
    );
  }

  void updateGiri(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateGiri');
    emit(state.copyWith(tipologia: value));
  }

  void updateArtista(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateArtista');
    emit(state.copyWith(autore: value));
  }

  void updateTitolo(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateTitolo');
    emit(state.copyWith(titoloAlbum: value));
  }

  void updatePosizione(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updatePosizione');
    emit(state.copyWith(posizione: value));
  }

  void updateOrdine(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateOrdine');
    emit(state.copyWith(ordine: value == '' ? null : int.parse(value)));
  }

  void updateAnno(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateAnno');
    emit(state.copyWith(anno: value));
  }

  void updateValore(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateValore');
    emit(state.copyWith(valore: value == '' ? null : double.parse(value)));
  }

  void updateBrano1A(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano1A');
    emit(state.copyWith(brano1A: value));
  }

  void updateBrano2A(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano2A');
    emit(state.copyWith(brano2A: value));
  }

  void updateBrano3A(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano3A');
    emit(state.copyWith(brano3A: value));
  }

  void updateBrano4A(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano4A');
    emit(state.copyWith(brano4A: value));
  }

  void updateBrano5A(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano5A');
    emit(state.copyWith(brano5A: value));
  }

  void updateBrano6A(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano6A');
    emit(state.copyWith(brano6A: value));
  }

  void updateBrano7A(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano7A');
    emit(state.copyWith(brano7A: value));
  }

  void updateBrano8A(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano8A');
    emit(state.copyWith(brano8A: value));
  }

  void updateBrano1B(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano1B');
    emit(state.copyWith(brano1B: value));
  }

  void updateBrano2B(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano2B');
    emit(state.copyWith(brano2B: value));
  }

  void updateBrano3B(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano3B');
    emit(state.copyWith(brano3B: value));
  }

  void updateBrano4B(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano4B');
    emit(state.copyWith(brano4B: value));
  }

  void updateBrano5B(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano5B');
    emit(state.copyWith(brano5B: value));
  }

  void updateBrano6B(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano6B');
    emit(state.copyWith(brano6B: value));
  }

  void updateBrano7B(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano7B');
    emit(state.copyWith(brano7B: value));
  }

  void updateBrano8B(String value) {
    logger.d('DettaglioDiscoCubit | Funzione: updateBrano8B');
    emit(state.copyWith(brano8B: value));
  }
}
