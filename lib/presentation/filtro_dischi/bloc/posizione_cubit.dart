import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

class PosizioneCubit extends Cubit<String?> {
  PosizioneCubit() : super(null);

  // Per gestire i log
  final logger = sl<Logger>();

  void setPosizione({String? posizione}) {
    logger.d('PosizioneCubit | Funzione: setPosizione');

    emit(posizione);
  }
}
