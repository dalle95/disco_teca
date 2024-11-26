import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/service_locator.dart';

import '/common/widgets/selezione_disco.dart';
import '/common/widgets/textfield_custom.dart';

import '/domain/disco/entities/disco.dart';
import '/domain/disco/usescases/elimina_disco.dart';

import '/presentation/dettaglio_disco/bloc/dettaglio_disco_cubit.dart';
import '/presentation/dettaglio_disco/bloc/lato_cubit.dart';
import '/presentation/dettaglio_disco/bloc/lista_posizioni/listaposizioni_state.dart';
import '/presentation/dettaglio_disco/bloc/inserimentoposizione_cubit.dart';
import '/presentation/dettaglio_disco/bloc/lista_posizioni/listaposizioni_cubit.dart';
import '/presentation/home/bloc/dischi_cubit/dischi_cubit.dart';

class DettaglioDiscoAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const DettaglioDiscoAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: AppBar(
        title: const Text('Dettaglio Disco'),
        actions: [
          IconButton(
            onPressed: () async {
              DiscoEntity disco = DiscoEntity.copyFrom(
                  context.read<DettaglioDiscoCubit>().state);
              await context.read<DettaglioDiscoCubit>().salvaDati(context);

              if (context.mounted) {
                DiscoEntity discoAggiornato =
                    context.read<DettaglioDiscoCubit>().state;

                context.read<DischiCubit>().aggiornaLista(
                      disco: discoAggiornato,
                      tipologia: disco.id == null
                          ? StatoAggiornamentoLista.aggiunta
                          : StatoAggiornamentoLista.modifica,
                    );

                Navigator.of(context).pop();
              }
            },
            icon: CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.save,
                size: 25,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          if (context.read<DettaglioDiscoCubit>().state.id != null)
            IconButton(
              onPressed: () async {
                DiscoEntity disco = context.read<DettaglioDiscoCubit>().state;

                await sl<EliminaDiscoUseCase>().call(params: disco);

                if (context.mounted) {
                  context.read<DischiCubit>().aggiornaLista(
                        disco: disco,
                        tipologia: StatoAggiornamentoLista.eliminazione,
                      );

                  Navigator.of(context).pop();
                }
              },
              icon: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.delete_forever_rounded,
                  size: 25,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SezioneDisco extends StatelessWidget {
  const SezioneDisco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DettaglioDiscoCubit, DiscoEntity>(
      builder: (context, disco) {
        return buildSelezioneDisco(
          context: context,
          onTap: (tipo) => context.read<DettaglioDiscoCubit>().updateGiri(tipo),
          tipologia: disco.giri,
        );
      },
    );
  }
}

class SezioneInformazioniDisco extends StatelessWidget {
  const SezioneInformazioniDisco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DettaglioDiscoCubit, DiscoEntity>(
        builder: (context, disco) {
      return Column(
        children: [
          // Artista
          TextFieldCustom(
            labelText: 'Artista',
            value: disco.artista,
            onChanged: (value) =>
                context.read<DettaglioDiscoCubit>().updateArtista(value),
          ),
          const SizedBox(height: 16),

          // Titolo Album
          TextFieldCustom(
            labelText: 'Titolo Album',
            value: disco.titoloAlbum,
            onChanged: (value) =>
                context.read<DettaglioDiscoCubit>().updateTitolo(value),
          ),
          const SizedBox(height: 16),

          // Selettore Modalità Inserimento Posizione
          BlocBuilder<InserimentoPosizioneCubit, bool>(
            builder: (context, posizioneEsistente) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Usa posizione esistente?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Switch(
                        value: posizioneEsistente,
                        onChanged: (value) => context
                            .read<InserimentoPosizioneCubit>()
                            .togglePosizione(),
                      ),
                    ],
                  ),
                  // Posizione (DropDown o TextField)
                  posizioneEsistente
                      ? BlocBuilder<ListaPosizioniCubit, ListaPosizioniState>(
                          builder: (context, state) {
                            if (state is ListaPosizioniLoading) {
                              return const CircularProgressIndicator();
                            }
                            if (state is ListaPosizioniLoaded) {
                              return DropdownButtonFormField<String>(
                                style: const TextStyle(
                                    fontStyle: FontStyle.normal),
                                value: context
                                    .read<DettaglioDiscoCubit>()
                                    .state
                                    .posizione,
                                decoration: const InputDecoration(
                                    labelText: 'Posizione'),
                                items:
                                    state.lista.map<DropdownMenuItem<String>>(
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
                                        .read<DettaglioDiscoCubit>()
                                        .updatePosizione(value);
                                  }
                                },
                              );
                            }
                            return Container();
                          },
                        )
                      : TextFieldCustom(
                          labelText: 'Posizione',
                          value: disco.posizione,
                          onChanged: (value) => context
                              .read<DettaglioDiscoCubit>()
                              .updatePosizione(value),
                        ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Ordine
          TextFieldCustom(
            labelText: 'Ordine',
            value: disco.ordine.toString(),
            onChanged: (value) =>
                context.read<DettaglioDiscoCubit>().updateOrdine(value),
          ),
          const SizedBox(height: 16),

          // Anno
          TextFieldCustom(
            labelText: 'Anno',
            value: disco.anno,
            onChanged: (value) =>
                context.read<DettaglioDiscoCubit>().updateAnno(value),
          ),
          const SizedBox(height: 16),

          // Valore
          TextFieldCustom(
            labelText: 'Valore',
            value: disco.valore.toString(),
            onChanged: (value) =>
                context.read<DettaglioDiscoCubit>().updateValore(value),
          ),
        ],
      );
    });
  }
}

class SezioneLatoDisco extends StatelessWidget {
  const SezioneLatoDisco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<LatoCubit, String>(
          builder: (context, lato) {
            return ToggleButtons(
              isSelected: [lato == 'A', lato == 'B'],
              onPressed: (index) => context.read<LatoCubit>().toggleLato(),
              fillColor: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
              borderColor: Theme.of(context).colorScheme.primary,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Lato A',
                    style: TextStyle(
                      color: lato == 'A'
                          ? Colors.deepOrangeAccent
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Lato B',
                    style: TextStyle(
                      color: lato == 'B'
                          ? Colors.deepOrangeAccent
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class SezioneBrani extends StatelessWidget {
  const SezioneBrani({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DettaglioDiscoCubit, DiscoEntity>(
      builder: (context, disco) {
        return BlocBuilder<LatoCubit, String>(
          builder: (context, lato) {
            return Column(
              children: [
                if (lato == 'A')
                  TextFieldCustom(
                    labelText: 'Brano 1',
                    value: disco.brano1A,
                    onChanged: (value) => context
                        .read<DettaglioDiscoCubit>()
                        .updateBrano1A(value),
                  ),
                if (lato == 'B')
                  TextFieldCustom(
                    labelText: 'Brano 1',
                    value: disco.brano1B,
                    onChanged: (value) => context
                        .read<DettaglioDiscoCubit>()
                        .updateBrano1B(value),
                  ),
                const SizedBox(height: 16),
                if ((disco.giri == '33' || disco.giri == 'CD') && lato == 'A')
                  Column(
                    children: [
                      TextFieldCustom(
                        labelText: 'Brano 2',
                        value: disco.brano2A,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano2A(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 3',
                        value: disco.brano3A,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano3A(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 4',
                        value: disco.brano4A,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano4A(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 5',
                        value: disco.brano5A,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano5A(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 6',
                        value: disco.brano6A,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano6A(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 7',
                        value: disco.brano7A,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano7A(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 8',
                        value: disco.brano8A,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano8A(value),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                if ((disco.giri == '33' || disco.giri == 'CD') && lato == 'B')
                  Column(
                    children: [
                      TextFieldCustom(
                        labelText: 'Brano 2',
                        value: disco.brano2B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano2B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 3',
                        value: disco.brano3B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano3B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 4',
                        value: disco.brano4B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano4B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 5',
                        value: disco.brano5B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano5B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 6',
                        value: disco.brano6B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano6B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 7',
                        value: disco.brano7B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano7B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: 'Brano 8',
                        value: disco.brano8B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano8B(value),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
