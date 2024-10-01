import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/global.dart';

import '/commons/entities/disco.dart';
import '/commons/routes/routes.dart';

import '/pages/dettaglio_disco/bloc/dettaglio_disco_events.dart';
import '/pages/filtro_dischi/bloc/filtro_dischi_blocs.dart';
import '/pages/filtro_dischi/bloc/filtro_dischi_events.dart';
import '/pages/filtro_dischi/ui/filtro_dischi_page.dart';
import '/pages/auth/ui/auth_page.dart';
import '/pages/auth/bloc/auth_blocs.dart';
import '/pages/home_page/bloc/home_blocs.dart';
import '/pages/home_page/ui/home_page.dart';
import '/pages/dettaglio_disco/bloc/dettaglio_disco_bloc.dart';
import '/pages/dettaglio_disco/ui/dettaglio_disco_page.dart';
import '/pages/profile/bloc/profile_blocs.dart';
import '/pages/profile/ui/profile_page.dart';

class AppPages {
  /// Lista di routes, pagine e bloc unite
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.AUTHENTICATION,
        page: const AuthPage(),
        bloc: AuthBloc(),
      ),
      PageEntity(
        route: AppRoutes.HOME_PAGE,
        page: const HomePage(),
        bloc: HomeBloc(),
      ),
      PageEntity(
        route: AppRoutes.DETTAGLIO_DISCO,
        page: const DettaglioDiscoPage(),
        bloc: DettaglioDiscoBloc(disco: Disco.empty()),
      ),
      PageEntity(
        route: AppRoutes.FILTRO,
        page: const FiltroDischiPage(),
        bloc: FiltroDischiBloc(),
      ),
      PageEntity(
        route: AppRoutes.PROFILE,
        page: const ProfilePage(),
        bloc: ProfileBloc(),
      ),
    ];
  }

  /// Funzione per gestire il routing
  static Future<Widget> generateRouteSettings(RouteSettings settings) async {
    // Logger per monitorare la route
    var logger = Logger();
    logger.d('Nome route: ${settings.name}');

    // Se la route è '/' (iniziale), controlla lo stato di login
    if (settings.name == AppRoutes.INITIAL) {
      bool isLoggedIn = await Global.storageService.getIsLoggedIn();
      logger.d('Utente loggato? $isLoggedIn');

      // Controllo dello stato di autenticazione
      if (isLoggedIn) {
        return HomePage();
      } else {
        return BlocProvider(
          create: (_) => AuthBloc(),
          child: const AuthPage(),
        );
      }
    }

    // Gestione delle altre rotte
    var result = routes().where((element) => element.route == settings.name);

    if (result.isNotEmpty) {
      if (result.first.route == AppRoutes.DETTAGLIO_DISCO) {
        return BlocProvider(
          create: (_) => DettaglioDiscoBloc(
            disco: settings.arguments != null
                ? Disco.fromJson(settings.arguments as Map<String, dynamic>)
                : Disco.empty(),
          )..add(
              InitializeEvent(
                disco: settings.arguments != null
                    ? Disco.fromJson(settings.arguments as Map<String, dynamic>)
                    : Disco.empty(),
              ),
            ),
          child: result.first.page,
        );
      }

      if (result.first.route == AppRoutes.FILTRO) {
        return BlocProvider(
          create: (_) => FiltroDischiBloc()
            ..add(
              FiltroDischiInitEvent(),
            ),
          child: result.first.page,
        );
      }

      if (result.first.route == AppRoutes.AUTHENTICATION) {
        return BlocProvider(
          create: (_) => AuthBloc(),
          child: result.first.page,
        );
      } else {
        return result.first.page;
      }
    }

    // Se nessuna route matcha, reindirizza alla pagina di autenticazione
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: const AuthPage(),
    );
  }
}

// Classe per unire i BlocProvider, le routes e le pagine
class PageEntity {
  String route;
  Widget page;
  Bloc? bloc;

  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}
