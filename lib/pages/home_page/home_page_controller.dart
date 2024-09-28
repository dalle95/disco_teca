import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/global.dart';

import '/commons/entities/disco.dart';
import '/commons/routes/routes/names.dart';
import '/commons/widgets/dialog_standard.dart';

import '/pages/auth/auth_controller.dart';
import '/pages/home_page/bloc/home_blocs.dart';
import '/pages/home_page/bloc/home_events.dart';

class HomePageController {
  final BuildContext context;

  const HomePageController({required this.context});

  /// Funzione per estrarre la lista dei clienti o delle locazioni
  Future<void> estraiDati() async {
    // Aggiorno il planner tramite il bloc
    if (context.mounted) {
      context.read<HomeBloc>().add(
            HomeInitDatiEvent(),
          );
    }
  }

  /// Funzione per estrarre la lista dei clienti o delle locazioni
  void ordinaDati({required String ordering}) {
    Logger().d('Funzione: ordinaDati');
    List<Disco> lista = List.from(context.read<HomeBloc>().state.lista);

    if (ordering == 'Titolo') {
      lista.sort(
        (a, b) => a.titoloAlbum!.compareTo(b.titoloAlbum!),
      );
    } else if (ordering == 'Anno') {
      lista.sort(
        (a, b) => a.anno!.compareTo(b.anno!),
      );
    } else if (ordering == 'Artista') {
      lista.sort(
        (a, b) => a.artista!.compareTo(b.artista!),
      );
    } else {
      lista.sort(
        (a, b) => a.posizione!.compareTo(b.posizione!),
      );
    }

    // Aggiorno il planner tramite il bloc
    if (context.mounted) {
      context.read<HomeBloc>().add(
            HomeUpdateDatiEvent(
              lista: lista,
              ordering: ordering,
            ),
          );
    }
  }

  /// Funzione per gestire il filtro quando è necessario attivarlo o disattivarlo
  void gestisciFiltro(
    String parametro,
    TextEditingController searchTextController,
  ) {
    if (parametro != '') {
      ricercaLista(parametro);
    } else {
      disattivaFiltro(searchTextController);
    }
  }

  /// Funzione per filtrare la lista in base al parametro
  Future<void> ricercaLista(String? parametro) async {
    // Estrazione lista dalla cache
    String listaSerializzata =
        (await Global.storageService.getData("listaDischi")).toString();

    // Conversione in lista
    List<dynamic> listaDinamica = jsonDecode(listaSerializzata);

    // Mappatura degli oggetti dinamici a oggetti di tipo Disco
    List<Disco> lista = listaDinamica.map((item) {
      return Disco.fromJson(item);
    }).toList();

    // Filtro la lista
    lista = lista.where((element) {
      return element.titoloAlbum
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.artista
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.anno
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano1A
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano2A
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano3A
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano4A
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano5A
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano6A
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano7A
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano8A
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano1B
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano2B
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano3B
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano4B
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano5B
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano6B
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano7B
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase()) ||
          element.brano8B
              .toString()
              .toLowerCase()
              .contains(parametro.toString().toLowerCase());
    }).toList();

    // Aggiorno la lista
    if (context.mounted) {
      context.read<HomeBloc>().add(
            HomeUpdateDatiEvent(
              lista: lista,
              filtroAttivo: true,
            ),
          );
    }
  }

  Future<void> disattivaFiltro(
      TextEditingController searchTextController) async {
    // Estrazione lista dalla cache
    String listaSerializzata =
        (await Global.storageService.getData("listaDischi")).toString();

    // Conversione in lista
    List<dynamic> listaDinamica = jsonDecode(listaSerializzata);

    // Mappatura degli oggetti dinamici a oggetti di tipo Cliente
    List<Disco> lista = listaDinamica.map((item) {
      return Disco.fromJson(item);
    }).toList();

    searchTextController.text = '';

    // Aggiorno l'elenco tramite il bloc
    if (context.mounted) {
      context.read<HomeBloc>().add(
            HomeUpdateDatiEvent(
              lista: lista,
              filtroAttivo: false,
            ),
          );
    }
  }

  /// Apertura pagina dettaglio Disco
  void paginaDettaglioDisco({Map<String, dynamic>? arguments}) {
    if (arguments == null) {
      final filtroStrutturato =
          context.read<HomeBloc>().state.filtroStrutturato;
      Logger().d(filtroStrutturato);

      if (filtroStrutturato != null) {
        final giri = filtroStrutturato.containsKey('giri')
            ? filtroStrutturato['giri']
            : null;
        final posizione = filtroStrutturato.containsKey('posizione')
            ? filtroStrutturato['posizione']
            : null;

        arguments = Disco(
          giri: giri,
          posizione: posizione,
          valore: 0,
        ).toJson();
      }
    }

    Navigator.of(context).pushNamed(
      AppRoutes.DETTAGLIO_DISCO,
      arguments: arguments,
    );
  }

  /// Apertura pagina Fitlro
  void paginaFiltro({Map<String, dynamic>? arguments}) {
    Navigator.of(context).pushNamed(
      AppRoutes.FILTRO,
      arguments: arguments,
    );
  }

  /// Dialogo per effettuare il logout
  void profileDialog() {
    dialogStandardPopUp(
      context: context,
      title: 'Disconnetti',
      content: 'Disconnettere l\'account?',
      acceptFunction: () {
        removeUserData();
      },
      deniedFunction: () {},
    );
  }

  // Funzione per effetturare il logout
  Future<void> removeUserData() async {
    AuthController(context: context).logout();
  }
}
