import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '/commons/widgets/loading_view.dart';

import '/pages/dettaglio_disco/bloc/dettaglio_disco_bloc.dart';
import '/pages/dettaglio_disco/bloc/dettaglio_disco_states.dart';
import '/pages/dettaglio_disco/widgets/dettaglio_disco_widgets.dart';

class DettaglioDiscoPage extends StatelessWidget {
  const DettaglioDiscoPage({super.key});

  @override
  Widget build(BuildContext context) {
    //return BlocProvider(create: (_) => DettaglioDiscoBloc(disco: ));
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: BlocBuilder<DettaglioDiscoBloc, DettaglioDiscoState>(
        builder: (context, state) {
          return state is DettaglioDiscoLoadingState
              ? buildLoadingView(context: context)
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      // Selezione Tipologia (33, 45, 78) con immagini e etichette
                      buildSelezioneDisco(context: context),
                      const Gap(16),

                      buildSezioneInformazioniDisco(context: context),
                      const Gap(24),

                      buildSelezioneLatoDisco(context: context),

                      const Gap(16),
                      buildSezioneBrani(context: context),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
