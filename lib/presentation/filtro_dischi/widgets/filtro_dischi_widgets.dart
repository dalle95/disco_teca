import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/selezione_disco.dart';

import '/presentation/filtro_dischi/bloc/lista_posizioni/listaposizioni_cubit.dart';
import '/presentation/filtro_dischi/bloc/lista_posizioni/listaposizioni_state.dart';
import '../bloc/giri_cubit.dart';
import '/presentation/filtro_dischi/bloc/posizione_cubit.dart';

class SezioneDisco extends StatelessWidget {
  const SezioneDisco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Titolo
        Text(
          'Tipologia Disco',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        BlocBuilder<GiriCubit, String?>(
          builder: (context, giri) {
            return buildSelezioneDisco(
              context: context,
              onTap: (tipo) {
                context.read<GiriCubit>().setGiri(context: context, giri: tipo);
                Navigator.of(context).pop();
              },
              tipologia: giri,
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class SezionePosizione extends StatelessWidget {
  const SezionePosizione({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Titolo Posizione
        Text(
          'Posizione',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        BlocProvider(
          create: (_) => ListaPosizioniCubit()..getListaPosizioni(),
          child: BlocBuilder<ListaPosizioniCubit, ListaPosizioniState>(
            builder: (context, state) {
              if (state is ListaPosizioniLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ListaPosizioniLoaded) {
                return BlocBuilder<PosizioneCubit, String?>(
                  builder: (context, posizione) {
                    return DropdownButtonFormField<String>(
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      value: posizione,
                      decoration: const InputDecoration(labelText: 'Posizione'),
                      items: state.lista.map<DropdownMenuItem<String>>(
                        (posizione) {
                          return DropdownMenuItem<String>(
                            value: posizione,
                            child: Text(posizione),
                          );
                        },
                      ).toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          context
                              .read<PosizioneCubit>()
                              .setPosizione(context: context, posizione: value);
                          Navigator.of(context).pop();
                        }
                      },
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
