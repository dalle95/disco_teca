import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/global.dart';

import '/commons/routes/routes/names.dart';

import '/pages/auth/ui/auth_page.dart';
import '/pages/auth/bloc/auth_blocs.dart';
import '/pages/home_page/bloc/home_blocs.dart';
import '/pages/home_page/ui/home_page.dart';
import '/pages/dettaglio_disco/bloc/dettaglio_disco_bloc.dart';
import '/pages/dettaglio_disco/ui/dettaglio_disco_page.dart';

class AppPages {
  /// Lista di routes, pagine e bloc unite
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const AuthPage(),
        bloc: BlocProvider(
          create: (_) => AuthBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.AUTHENTICATION,
        page: const AuthPage(),
        bloc: BlocProvider(
          create: (_) => AuthBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.HOME_PAGE,
        page: const HomePage(),
        bloc: BlocProvider(
          create: (_) => HomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.DETTAGLIO_DISCO,
        page: const DettaglioDiscoPage(),
        bloc: BlocProvider(
          create: (_) => DettaglioDiscoBloc(),
        ),
      ),
    ];
  }

  /// Funzione per estrarre la lista dei bloc
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    // Itero per ogni routes per estrarre tutti i bloc
    for (var bloc in routes()) {
      // Controllo che il bloc esiste
      if (bloc.bloc != null) {
        // Aggiungo alla lista dei bloc
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  ///Funzione per gestire il routing
  static Future<Widget> generateRouteSettings(RouteSettings settings) async {
    // Per gestire i log
    var logger = Logger();

    logger.d('Nome route: ${settings.name}');

    // Controllo se è presente il nome di una pagina
    if (settings.name != null) {
      // Controllo il match della route con il nome della pagina quando il navigator viene eseguito
      var result = routes().where(
        (element) => element.route == settings.name,
      );

      // Controllo sia presente una route associata
      if (result.isNotEmpty) {
        if (result.first.route == AppRoutes.INITIAL) {
          // Estraggo il dato se l'utente è già loggato estranedo le info dal device
          bool isLoggedin = await Global.storageService.getIsLoggedIn();

          logger.d('Utente loggato? $isLoggedin');

          // Controllo se l'utente è già loggato
          if (isLoggedin) {
            // Se è già loggato visualizza la Homepage
            return const HomePage();
          }

          // Altrimenti visualizza lo pagina di Autenticazione
          return const AuthPage();
        } else {
          return result.first.page;
        }
      }
    }

    return const AuthPage();
  }
}

// Classe per unire i BlocProvider, le routes e le pagine
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}
