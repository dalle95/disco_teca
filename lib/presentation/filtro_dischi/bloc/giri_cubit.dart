import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/presentation/home/bloc/dischi_cubit/dischi_cubit.dart';
import '/presentation/home/bloc/ordine_dischi_cubit.dart';

class GiriCubit extends Cubit<String?> {
  GiriCubit() : super(null);

  // Per gestire i log
  final logger = sl<Logger>();

  void setGiri({BuildContext? context, String? giri}) {
    logger.d('DiscoCubit | Funzione: setGiri');
    // Aggiorno la lista con il filtro sui giri
    if (context != null && giri != null) {
      context.read<DischiCubit>().getFiltraDischi(
            attributo: AttributoFiltro.giri,
            parametro: giri,
          );
    } else {
      String ordine = context!.read<OrdineDischiCubit>().state;
      context.read<DischiCubit>().getDischi(ordine: ordine);
    }
    emit(giri);
  }
}
