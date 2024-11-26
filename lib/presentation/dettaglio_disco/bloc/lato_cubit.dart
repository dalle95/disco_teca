import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

class LatoCubit extends Cubit<String> {
  LatoCubit() : super("A");

  // Per gestire i log
  final logger = sl<Logger>();

  void toggleLato() {
    logger.d('LatoCubit | Funzione: toggleLato');
    if (state == "A") {
      emit("B");
    } else {
      emit("A");
    }
  }
}
