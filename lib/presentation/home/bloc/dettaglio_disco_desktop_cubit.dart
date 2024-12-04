import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/disco/entities/disco.dart';

class DettaglioDiscoDesktopCubit extends Cubit<DiscoEntity?> {
  DettaglioDiscoDesktopCubit() : super(null);

  // Per gestire i log
  final logger = sl<Logger>();

  void setDisco(DiscoEntity disco) {
    logger.d('DettaglioDiscoDesktopCubit | Funzione: setDisco');

    emit(disco);
  }

  void setNuovoDisco() {
    logger.d('DettaglioDiscoDesktopCubit | Funzione: setNuovoDisco');

    emit(DiscoEntity.empty());
  }

  void setNessunDisco() {
    logger.d('DettaglioDiscoDesktopCubit | Funzione: setNessunDisco');

    emit(null);
  }
}
