import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/common/widgets/responsive.dart';

import '/domain/disco/usescases/elimina_disco.dart';
import '/domain/disco/entities/disco.dart';
import '/domain/disco/usescases/salva_disco.dart';

import '/presentation/dettaglio_disco/bloc/ui_state/ui_state_cubit.dart';
import '/presentation/home/bloc/dettaglio_disco_desktop_cubit.dart';
import '/presentation/foto_disco/bloc/foto_disco_cubit.dart';

class DettaglioDiscoCubit extends Cubit<DiscoEntity> {
  DettaglioDiscoCubit(DiscoEntity initialState) : super(initialState);

  // Per gestire i log
  final logger = sl<Logger>();

  Future<void> salvaDati(BuildContext context) async {
    logger.d('DettaglioDiscoCubit | Funzione: salvaDati');

    // DiscoEntity disco = DiscoEntity.copyFrom(state);

    // Validation checks
    List<String> missingFields = [];
    if (state.giri == null || state.giri!.isEmpty) {
      missingFields.add('Giri');
    }
    if (state.artista == null || state.artista!.isEmpty) {
      missingFields.add('Artista');
    }
    if (state.titoloAlbum == null || state.titoloAlbum!.isEmpty) {
      missingFields.add('Titolo Album');
    }
    if (state.posizione == null || state.posizione!.isEmpty) {
      missingFields.add('Posizione');
    }
    if (state.ordine == null) {
      missingFields.add('Ordine');
    }
    if (state.anno == null || state.anno!.isEmpty) {
      missingFields.add('Anno');
    }

    if (missingFields.isNotEmpty) {
      context.read<UIStateCubit>().setError(
          'I seguenti campi non possono essere vuoti: ${missingFields.join(', ')}');
      return;
    }
    if (missingFields.isEmpty) {
      var data = await sl<SalvaDiscoUseCase>().call(params: state);
      data.fold(
        (error) {
          logger.d(error);
          context.read<UIStateCubit>().setError('Salvataggio fallito: $error');
        },
        (data) async {
          DiscoEntity discoAggiornato = data;

          logger.d(discoAggiornato.toJson());

          // context.read<DischiCubit>().aggiornaLista(
          //       disco: discoAggiornato,
          //       tipologia: disco.id == null
          //           ? StatoAggiornamentoLista.aggiunta
          //           : StatoAggiornamentoLista.modifica,
          //     );

          context.read<UIStateCubit>().setSuccess('Disco salvato con successo');

          bool isMobile = Responsive.isMobile(context);

          emit(discoAggiornato);

          if (isMobile) {
            Navigator.of(context).pop();
          }

          // Upload images to Firebase Storage
          await context
              .read<FotoDiscoCubit>()
              .uploadImagesToFirebase(discoAggiornato.id!);
        },
      );
    }
  }

  void aggiornaDisco(DiscoEntity disco) {
    logger.d('DettaglioDiscoCubit | Funzione: aggiornaDisco');
    emit(
      state.copyWith(
        autore: disco.artista,
        titoloAlbum: disco.titoloAlbum,
        brano1A: disco.brano1A,
        brano2A: disco.brano2A,
        brano3A: disco.brano3A,
        brano4A: disco.brano4A,
        brano5A: disco.brano5A,
        brano6A: disco.brano6A,
        brano7A: disco.brano7A,
        brano8A: disco.brano8A,
        brano1B: disco.brano1B,
        brano2B: disco.brano2B,
        brano3B: disco.brano3B,
        brano4B: disco.brano4B,
        brano5B: disco.brano5B,
        brano6B: disco.brano6B,
        brano7B: disco.brano7B,
        brano8B: disco.brano8B,
      ),
    );
  }

  Future<void> eliminaDisco(BuildContext context) async {
    logger.d('DettaglioDiscoCubit | Funzione: eliminaDisco');

    final data = await sl<EliminaDiscoUseCase>().call(params: state);

    data.fold(
      (error) {
        logger.d(error);
        context.read<UIStateCubit>().setError('Eliminazione fallita: $error');
        emit(state);
      },
      (data) async {
        if (context.mounted) {
          // context.read<DischiCubit>().aggiornaLista(
          //       disco: state,
          //       tipologia: StatoAggiornamentoLista.eliminazione,
          //     );
          bool isMobile = Responsive.isMobile(context);

          if (isMobile) {
            Navigator.of(context).pop();
          } else {
            context.read<DettaglioDiscoDesktopCubit>().setNessunDisco();
          }
          context
              .read<UIStateCubit>()
              .setSuccess('Disco eliminato con successo');
          // Per cancellare tutte le immagini
          context.read<FotoDiscoCubit>().deleteAllImages();
          close();
        }
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

    double parseDoubleInput(String value) {
      if (value.isEmpty) return 0.0;

      // Replace comma with period
      String sanitized = value.replaceAll(',', '.');

      // Handle multiple decimal points - keep only first one
      int firstDecimalIndex = sanitized.indexOf('.');
      if (firstDecimalIndex != -1) {
        String beforeDecimal = sanitized.substring(0, firstDecimalIndex + 1);
        String afterDecimal =
            sanitized.substring(firstDecimalIndex + 1).replaceAll('.', '');
        sanitized = beforeDecimal + afterDecimal;
      }

      return double.tryParse(sanitized) ?? 0.0;
    }

    emit(state.copyWith(valore: value == '' ? null : parseDoubleInput(value)));
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
