import 'package:disco_teca/pages/filtro_dischi/bloc/filtro_dischi_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/filtro_dischi_blocs.dart';

import '/commons/widgets/dropdown_field.dart';
import '/commons/widgets/selezione_disco.dart';

import '/pages/filtro_dischi/bloc/filtro_dischi_states.dart';
import '/pages/filtro_dischi/filtro_dischi_page_controller.dart';
import '/pages/filtro_dischi/widgets/filtro_dischi_widgets.dart';

class FiltroDischiPage extends StatelessWidget {
  const FiltroDischiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FiltroDischiBloc()
        ..add(
          FiltroDischiInitEvent(),
        ),
      child: BlocBuilder<FiltroDischiBloc, FiltroDischiState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(
              context: context,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titolo
                  Text(
                    'Tipologia Disco',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),

                  // Selezione Giri
                  buildSelezioneDisco(
                    context: context,
                    onTap: (giri) => FiltroDischiController(context: context)
                        .updateGiri(giri),
                    tipologia: state.giri,
                  ),
                  const SizedBox(height: 20),

                  // Titolo Posizione
                  Text(
                    'Posizione',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),

                  // Selezione Posizione (con DropDown)
                  dropDownField(
                    context: context,
                    valore: state.posizione,
                    elenco: state.listaPosizioni,
                    onChanged: (String? posizione) {
                      // Gestisci il cambio della posizione
                      FiltroDischiController(context: context)
                          .updatePosizione(posizione!);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
