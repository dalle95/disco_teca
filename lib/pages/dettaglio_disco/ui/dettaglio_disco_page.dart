import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '/pages/dettaglio_disco/bloc/dettaglio_disco_bloc.dart';
import '/pages/dettaglio_disco/bloc/dettaglio_disco_states.dart';
import '/pages/dettaglio_disco/dettaglio_disco_controller.dart';
import '/pages/dettaglio_disco/widgets/dettaglio_disco_widgets.dart';

class DettaglioDiscoPage extends StatefulWidget {
  const DettaglioDiscoPage({super.key});

  @override
  State<DettaglioDiscoPage> createState() => _DettaglioDiscoPageState();
}

class _DettaglioDiscoPageState extends State<DettaglioDiscoPage> {
  late DettaglioDiscoController _controller;

  @override
  void didChangeDependencies() {
    _controller = DettaglioDiscoController(context: context);
    _controller.init();

    _controller.estraiDettaglio();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: BlocBuilder<DettaglioDiscoBloc, DettaglioDiscoState>(
        builder: (context, state) {
          return Padding(
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
