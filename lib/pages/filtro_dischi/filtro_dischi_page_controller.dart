import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/commons/entities/disco.dart';

import '/pages/filtro_dischi/bloc/filtro_dischi_blocs.dart';
import '/pages/filtro_dischi/bloc/filtro_dischi_events.dart';
import '/pages/home_page/bloc/home_blocs.dart';
import '/pages/home_page/bloc/home_events.dart';

class FiltroDischiController {
  final BuildContext context;

  FiltroDischiController({required this.context});

  /// Funzione per aggiornare i giri
  void updateGiri(String giri) {
    List<Disco> listaDischi = context.read<HomeBloc>().state.lista;

    listaDischi =
        List.from(listaDischi.where((element) => element.giri == giri));

    listaDischi.sort(
      (a, b) {
        if (a.artista != null && b.artista != null) {
          return a.artista!.compareTo(b.artista!);
        }
        return 1;
      },
    );

    final filtroStrutturato = {
      'giri': giri,
    };

    context.read<FiltroDischiBloc>().add(
          UpdateGiriEvent(
            giri: giri,
          ),
        );

    context.read<HomeBloc>().add(
          HomeUpdateDatiEvent(
            lista: listaDischi,
            filtroStrutturatoAttivo: true,
            filtroStrutturato: filtroStrutturato,
          ),
        );

    Navigator.of(context).pop();
  }

  /// Funzione per aggiornare la posizione
  void updatePosizione(String posizione) {
    Logger().d('updatePosizione');

    List<Disco> listaDischi = context.read<HomeBloc>().state.lista;

    listaDischi = List.from(
        listaDischi.where((element) => element.posizione == posizione));

    listaDischi.sort(
      (a, b) {
        return a.ordine!.compareTo(b.ordine!);
      },
    );

    final filtroStrutturato = {
      'posizione': posizione,
    };

    context.read<FiltroDischiBloc>().add(
          UpdatePosizioneEvent(
            posizione: posizione,
          ),
        );

    context.read<HomeBloc>().add(
          HomeUpdateDatiEvent(
            lista: listaDischi,
            filtroStrutturatoAttivo: true,
            filtroStrutturato: filtroStrutturato,
          ),
        );

    Navigator.of(context).pop();
  }
}
