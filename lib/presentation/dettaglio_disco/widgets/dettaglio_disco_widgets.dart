import 'package:app_disco_teca/presentation/dettaglio_disco/bloc/ui_state/ui_state_cubit.dart';
import 'package:app_disco_teca/presentation/foto_disco/bloc/foto_disco_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/selezione_disco.dart';
import '/common/widgets/textfield_custom.dart';
import '/common/widgets/responsive.dart';
import '/common/helper/navigation/app_navigation.dart';

import '/domain/disco/entities/disco.dart';

import '/presentation/dettaglio_disco/bloc/dettaglio_disco_cubit.dart';
import '/presentation/dettaglio_disco/bloc/lato_cubit.dart';
import '/presentation/dettaglio_disco/bloc/lista_posizioni/listaposizioni_state.dart';
import '/presentation/dettaglio_disco/bloc/inserimentoposizione_cubit.dart';
import '/presentation/dettaglio_disco/bloc/lista_posizioni/listaposizioni_cubit.dart';
import '/presentation/home/bloc/dischi_cubit/dischi_cubit.dart';
import '../../foto_disco/pages/foto_disco_page.dart';

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
      child: BlocBuilder<DettaglioDiscoCubit, DiscoEntity>(
        builder: (context, state) {
          return AppBar(
            title: const Text('Dettaglio Disco'),
            actions: Responsive.isMobile(context)
                ? null
                : [
                    IconButton(
                      onPressed: () async {
                        AppNavigator.push(
                          context,
                          MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<UIStateCubit>(),
                              ),
                              BlocProvider.value(
                                value: context.read<DettaglioDiscoCubit>(),
                              ),
                              BlocProvider.value(
                                value: context.read<FotoDiscoCubit>(),
                              ),
                            ],
                            child: FotoDiscoPage(),
                          ),
                        );
                      },
                      icon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.image,
                          size: 30,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await context
                            .read<DettaglioDiscoCubit>()
                            .salvaDati(context);
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
                    if (state.id != null)
                      IconButton(
                        onPressed: () async {
                          await context
                              .read<DettaglioDiscoCubit>()
                              .eliminaDisco(context);
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Icon(
                            Icons.delete_forever_rounded,
                            size: 25,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                  ],
          );
        },
      ),
    );
  }
}

class FloatingActionButtons extends StatelessWidget {
  const FloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DettaglioDiscoCubit, DiscoEntity>(
      builder: (context, state) {
        return !Responsive.isMobile(context)
            ? SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      AppNavigator.push(
                        context,
                        MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: context.read<UIStateCubit>(),
                            ),
                            BlocProvider.value(
                              value: context.read<DettaglioDiscoCubit>(),
                            ),
                            BlocProvider.value(
                              value: context.read<FotoDiscoCubit>(),
                            ),
                          ],
                          child: FotoDiscoPage(),
                        ),
                      );
                    },
                    icon: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Icon(
                        Icons.image,
                        size: 30,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  if (state.id != null)
                    IconButton(
                      onPressed: () async {
                        await context
                            .read<DettaglioDiscoCubit>()
                            .eliminaDisco(context);
                      },
                      icon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.delete_forever_rounded,
                          size: 30,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  IconButton(
                    onPressed: () async {
                      await context
                          .read<DettaglioDiscoCubit>()
                          .salvaDati(context);
                    },
                    icon: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Icon(
                        Icons.save,
                        size: 30,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              );
      },
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
              value: disco.artista ?? '',
              onChanged: (value) =>
                  context.read<DettaglioDiscoCubit>().updateArtista(value),
            ),
            const SizedBox(height: 16),

            // Titolo Album
            TextFieldCustom(
              labelText: 'Titolo Album',
              value: disco.titoloAlbum ?? '',
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
                                return const Text(
                                    'Nessuna posizione disponibile');
                              }

                              return DropdownButtonFormField<String>(
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
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
                                onChanged: (String? value) async {
                                  if (value != null) {
                                    context
                                        .read<DettaglioDiscoCubit>()
                                        .updatePosizione(value);

                                    int ordine = await context
                                        .read<DischiCubit>()
                                        .getOrdinePosizione(posizione: value);
                                    context
                                        .read<DettaglioDiscoCubit>()
                                        .updateOrdine(ordine.toString());
                                  }
                                },
                              );
                            },
                          )
                        : TextFieldCustom(
                            labelText: 'Posizione',
                            value: disco.posizione ?? '',
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
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    final currentValue = disco.ordine ?? 0;
                    context
                        .read<DettaglioDiscoCubit>()
                        .updateOrdine((currentValue - 1).toString());
                  },
                ),
                Expanded(
                  child: TextFieldCustom(
                    textAlign: TextAlign.center,
                    labelText: 'Ordine',
                    keyboardType: TextInputType.number,
                    value: disco.ordine == 0 || disco.ordine == null
                        ? ''
                        : disco.ordine.toString(),
                    onChanged: (value) =>
                        context.read<DettaglioDiscoCubit>().updateOrdine(value),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final currentValue = disco.ordine ?? 0;
                    context
                        .read<DettaglioDiscoCubit>()
                        .updateOrdine((currentValue + 1).toString());
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Anno
            TextFieldCustom(
              labelText: 'Anno',
              keyboardType: TextInputType.number,
              value: disco.anno ?? '',
              onChanged: (value) =>
                  context.read<DettaglioDiscoCubit>().updateAnno(value),
            ),
            const SizedBox(height: 16),

            // Valore
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    final currentValue = disco.valore ?? 0.0;
                    context
                        .read<DettaglioDiscoCubit>()
                        .updateValore((currentValue - 0.5).toString());
                  },
                ),
                Expanded(
                  child: TextFieldCustom(
                    labelText: 'Valore',
                    prefixIcon: const Icon(Icons.euro),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    value: (disco.valore == 0 ||
                            disco.valore == 0.0 ||
                            disco.valore == null)
                        ? ''
                        : disco.valore! % 1 == 0
                            ? disco.valore!.toInt().toString()
                            : disco.valore.toString(),
                    onChanged: (value) =>
                        context.read<DettaglioDiscoCubit>().updateValore(value),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final currentValue = disco.valore ?? 0.0;
                    context
                        .read<DettaglioDiscoCubit>()
                        .updateValore((currentValue + 0.5).toString());
                  },
                ),
              ],
            )
          ],
        );
      },
    );
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
        BlocBuilder<DettaglioDiscoCubit, DiscoEntity>(
            builder: (context, disco) {
          return disco.giri == 'CD'
              ? ToggleButtons(
                  disabledColor: Theme.of(context).colorScheme.surface,
                  selectedColor: Theme.of(context).colorScheme.surface,
                  color: Theme.of(context).colorScheme.surface,
                  isSelected: const [true], // Always 'selected' for style
                  onPressed: null, // No interaction
                  fillColor: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                  borderColor: Theme.of(context).colorScheme.primary,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Lista',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              : BlocBuilder<LatoCubit, String>(
                  builder: (context, lato) {
                    return ToggleButtons(
                      isSelected: [lato == 'A', lato == 'B'],
                      onPressed: (index) =>
                          context.read<LatoCubit>().toggleLato(),
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
                );
        }),
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
                if ((disco.giri == '33' || disco.giri == 'CD') && lato == 'A')
                  Column(
                    children: [
                      const SizedBox(height: 16),
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
                if ((lato == 'B') || disco.giri == 'CD')
                  TextFieldCustom(
                    labelText: disco.giri != 'CD' ? 'Brano 1' : 'Brano 9',
                    value: disco.brano1B,
                    onChanged: (value) => context
                        .read<DettaglioDiscoCubit>()
                        .updateBrano1B(value),
                  ),
                if ((disco.giri == '33' && lato == 'B') || disco.giri == 'CD')
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: disco.giri != 'CD' ? 'Brano 2' : 'Brano 10',
                        value: disco.brano2B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano2B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: disco.giri != 'CD' ? 'Brano 3' : 'Brano 11',
                        value: disco.brano3B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano3B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: disco.giri != 'CD' ? 'Brano 4' : 'Brano 12',
                        value: disco.brano4B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano4B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: disco.giri != 'CD' ? 'Brano 5' : 'Brano 13',
                        value: disco.brano5B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano5B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: disco.giri != 'CD' ? 'Brano 6' : 'Brano 14',
                        value: disco.brano6B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano6B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: disco.giri != 'CD' ? 'Brano 7' : 'Brano 15',
                        value: disco.brano7B,
                        onChanged: (value) => context
                            .read<DettaglioDiscoCubit>()
                            .updateBrano7B(value),
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        labelText: disco.giri != 'CD' ? 'Brano 8' : 'Brano 16',
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
