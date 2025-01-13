import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/scaffold_message.dart';

import '/domain/disco/entities/disco.dart';

import '/presentation/foto_disco/bloc/foto_disco_cubit.dart';
import '/presentation/dettaglio_disco/bloc/inserimentoposizione_cubit.dart';
import '/presentation/dettaglio_disco/bloc/lato_cubit.dart';
import '/presentation/dettaglio_disco/bloc/dettaglio_disco_cubit.dart';
import '/presentation/dettaglio_disco/bloc/lista_posizioni/listaposizioni_cubit.dart';
import '/presentation/dettaglio_disco/widgets/dettaglio_disco_widgets.dart';
import '/presentation/dettaglio_disco/bloc/ui_state/ui_state_cubit.dart';
import '/presentation/dettaglio_disco/bloc/ui_state/ui_state_state.dart';

class DettaglioDiscoPage extends StatelessWidget {
  final DiscoEntity disco;
  const DettaglioDiscoPage({super.key, required this.disco});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UIStateCubit()),
        BlocProvider(create: (_) => DettaglioDiscoCubit(disco)),
        BlocProvider(
          create: (_) =>
              InserimentoPosizioneCubit(disco.posizione != null ? true : false),
        ),
        BlocProvider(create: (_) => ListaPosizioniCubit()),
        BlocProvider(create: (_) => LatoCubit()),
        BlocProvider(
          create: (_) => FotoDiscoCubit(disco.id),
          lazy: false,
        )
      ],
      child: BlocListener<UIStateCubit, UIState>(
        listener: (context, state) {
          if (state is Error) {
            showScaffoldMessage(
              context: context,
              message: state.message,
            );
          } else if (state is Success) {
            showScaffoldMessage(
              context: context,
              message: state.message,
            );
          }
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButtons(),
          appBar: DettaglioDiscoAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: const [
                SizedBox(height: 16),
                // Selezione Tipologia (33, 45, 78) con immagini e etichette
                SezioneDisco(),
                SizedBox(height: 16),
                // Sezione Informazioni Disco (dati)
                SezioneInformazioniDisco(),
                SizedBox(height: 24),
                // Sezione Lato Disco (A o B)
                SezioneLatoDisco(),
                SizedBox(height: 16),
                // Sezione Elenco Brani
                SezioneBrani(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
