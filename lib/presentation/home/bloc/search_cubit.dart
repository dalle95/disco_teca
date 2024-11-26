import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');

  // Per gestire i log
  final logger = sl<Logger>();

  void updateRicerca(String value) {
    logger.d('SearchCubit | Funzione: updateRicerca');
    emit(value);
  }
}
