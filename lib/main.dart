import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/global.dart';

import '/commons/routes/pages.dart';
import '/commons/values/tema.dart';
import '/commons/widgets/loading_view.dart';

import '/pages/home_page/bloc/home_blocs.dart';

Future<void> main() async {
  // Assicurati che i binding di Flutter siano inizializzati
  WidgetsFlutterBinding.ensureInitialized();

  await Global.init();

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // MultiBlocProvider(
        //   providers: [
        //     ...AppPages.allBlocProviders(context),
        //   ],
        BlocProvider(
      create: (_) => HomeBloc(),
      child: MaterialApp(
        title: 'MYW',
        theme: tema,
        supportedLocales: const [
          Locale('it'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => FutureBuilder<Widget>(
              future: AppPages.generateRouteSettings(settings),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Mostra un indicatore di caricamento mentre attendi il risultato
                  return Scaffold(
                    body: buildLoadingView(context: context),
                  );
                } else if (snapshot.hasError) {
                  // Gestisci eventuali errori
                  return Scaffold(
                    body: Center(
                      child: Text('Errore: ${snapshot.error}'),
                    ),
                  );
                } else {
                  // Quando i dati sono disponibili, costruisci il widget desiderato
                  return snapshot.data ??
                      const Scaffold(
                        body: Center(
                          child: Text('Errore: Nessun dato disponibile'),
                        ),
                      );
                }
              },
            ),
            settings: settings,
          );
        },
      ),
    );
  }
}
