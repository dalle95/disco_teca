import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

class GiriCubit extends Cubit<String?> {
  GiriCubit() : super(null);

  // Per gestire i log
  final logger = sl<Logger>();

  void setGiri({String? giri}) {
    logger.d('DiscoCubit | Funzione: setGiri');

    emit(giri);
  }
}
