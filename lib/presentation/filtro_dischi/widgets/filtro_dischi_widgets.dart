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
                context.read<GiriCubit>().setGiri(giri: tipo);
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
          create: (_) => ListaPosizioniCubit(),
          child: BlocBuilder<ListaPosizioniCubit, ListaPosizioniState>(
            builder: (context, state) {
              // 1) Loading
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }

              // 2) Error
              if (state.errorMessage != null) {
                return Text(
                  'Errore: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                );
              }

              // 3) Show the dropdown if we have a valid list
              final listaPosizioni = state.lista;
              if (listaPosizioni.isEmpty) {
                return const Text('Nessuna posizione disponibile');
              }

              // Show the dropdown using the current PosizioneCubit
              return BlocBuilder<PosizioneCubit, String?>(
                builder: (context, posizione) {
                  return DropdownButtonFormField<String>(
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    value: posizione,
                    decoration: const InputDecoration(labelText: 'Posizione'),
                    items: listaPosizioni.map<DropdownMenuItem<String>>(
                      (pos) {
                        return DropdownMenuItem<String>(
                          value: pos,
                          child: Text(pos),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        // Update the PosizioneCubit
                        context
                            .read<PosizioneCubit>()
                            .setPosizione(posizione: value);
                        Navigator.of(context).pop();
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
