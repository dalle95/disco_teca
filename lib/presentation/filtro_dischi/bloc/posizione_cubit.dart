import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/presentation/home/bloc/dischi_cubit/dischi_cubit.dart';
import '/presentation/home/bloc/ordine_dischi_cubit.dart';

class PosizioneCubit extends Cubit<String?> {
  PosizioneCubit() : super(null);

  // Per gestire i log
  final logger = sl<Logger>();

  void setPosizione({BuildContext? context, String? posizione}) {
    logger.d('PosizioneCubit | Funzione: setPosizione');

    // Aggiorno la lista con il filtro sulla posizione
    if (context != null && posizione != null) {
      context.read<DischiCubit>().getFiltraDischi(
            attributo: AttributoFiltro.posizione,
            parametro: posizione,
          );
    } else {
      String ordine = context!.read<OrdineDischiCubit>().state;
      context.read<DischiCubit>().getDischi(ordine: ordine);
    }

    emit(posizione);
  }
}
