import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

class InserimentoPosizioneCubit extends Cubit<bool> {
  InserimentoPosizioneCubit(bool posizioneEsistente)
      : super(posizioneEsistente);

  // Per gestire i log
  final logger = sl<Logger>();

  void togglePosizione() {
    logger.d('InserimentoPosizioneCubit | Funzione: togglePosizione');
    if (state == true) {
      emit(false);
    } else {
      emit(true);
    }
  }
}
