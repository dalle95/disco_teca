import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/commons/entities/disco.dart';
import '/commons/utils/error_util.dart';
import '/commons/data/api/dischi_api.dart';

import '/pages/dettaglio_disco/bloc/dettaglio_disco_bloc.dart';
import '/pages/dettaglio_disco/bloc/dettaglio_disco_events.dart';
import '/pages/home_page/bloc/home_blocs.dart';
import '/pages/home_page/bloc/home_events.dart';

class DettaglioDiscoController {
  final BuildContext context;
  Map<String, dynamic>? _data;

  DettaglioDiscoController({required this.context});

  /// Funzione per settare i dati relativi al WO
  void setDati(Map<String, dynamic>? data) {
    _data = data;
  }

  /// Funzione per estrarre i dati relativi al WO
  Map<String, dynamic>? getDati() {
    return _data;
  }

  /// Funzione per inizializzare i dati relativi al WO
  void init() async {
    Logger().d('Funzione: init');

    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    setDati(data);
  }

  /// Funzione per estrarre i dati del dettaglio
  Future<void> estraiDettaglio() async {
    Logger().d('Funzione: estraiDettaglio');

    Disco disco = Disco.empty();

    // Estraggo i dati passati come argomento e li converto in entità
    if (getDati() != null) {
      disco = Disco.fromJson(getDati()!);
    }

    Logger().d(disco.toJson());

    try {
      // Controllo che il context è presente e aggiorno il bloc
      if (context.mounted) {
        context.read<DettaglioDiscoBloc>().add(
              InitializeEvent(disco: disco),
            );
      }
    } on CustomHttpException catch (e) {
      throw '$e';
    } catch (e) {
      rethrow;
    }
  }

  /// Funzione per salvare le modifiche al dettaglio
  void aggiornaDettaglio() async {
    Logger().d('Funzione: aggiornaDettaglio');

    Disco disco = context.read<DettaglioDiscoBloc>().state.disco;

    Logger().d(disco.toJson());

    // Controllo se il dettaglio è da aggiornare o da aggiungere
    if (disco.id != null) {
      // Aggiornamento dettaglio già esistente

      // Aggiorna i dati su Firebase
      await DiscoApi().aggiornaDisco(disco);

      // Aggiorno la lista nel bloc
      if (context.mounted) {
        context.read<HomeBloc>().add(
              HomeUpdateDatiEvent(
                disco: disco,
              ),
            );
      }
    } else {
      // Aggiunta nuovo elemento

      // Aggiungo i dati su Firebase
      disco = await DiscoApi().creaDisco(disco);

      // Aggiorno la lista nel bloc
      if (context.mounted) {
        context.read<HomeBloc>().add(
              HomeCreateDatiEvent(
                disco: disco,
              ),
            );
      }
    }
  }
}
