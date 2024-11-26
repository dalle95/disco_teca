import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

class OrdineDischiCubit extends Cubit<String> {
  OrdineDischiCubit() : super('Artista');

  // Per gestire i log
  final logger = sl<Logger>();

  void cambiaCriterio(String criterio) {
    logger.d('OrdineDischiCubit | Funzione: cambiaCriterio');
    emit(criterio);
  }
}
