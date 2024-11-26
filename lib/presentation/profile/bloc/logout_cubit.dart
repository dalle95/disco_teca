import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/auth/usecases/logout.dart';

class LogoutCubit extends Cubit<bool> {
  LogoutCubit() : super(false);

  // Per gestire i log
  final logger = sl<Logger>();

  void logout() async {
    logger.d("LogoutCubit | Funzione: logout");
    await sl<LogoutUseCase>().call();
    emit(true);
  }
}
