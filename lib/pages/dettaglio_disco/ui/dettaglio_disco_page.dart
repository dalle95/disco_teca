import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/pages/dettaglio_disco/bloc/dettaglio_disco_bloc.dart';
import '/pages/dettaglio_disco/bloc/dettaglio_disco_events.dart';
import '/pages/dettaglio_disco/bloc/dettaglio_disco_states.dart';
import '/pages/dettaglio_disco/dettaglio_disco_controller.dart';

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
      appBar: AppBar(
        title: const Text('Dettaglio Disco'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.aggiornaDettaglio();
              Navigator.of(context).pop();
            },
            icon: Stack(
              alignment: Alignment.center,
              children: [
                // Icona del disco
                SizedBox(
                  height: 50,
                  child: Icon(
                    Icons.album,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                // Simbolo del salvataggio (floppy disk o dischetto)
                SizedBox(
                  height: 50,
                  child: Icon(
                    Icons.save,
                    size: 20,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<DettaglioDiscoBloc, DettaglioDiscoState>(
        builder: (context, state) {
          TextEditingController artista = state.artistaController;
          TextEditingController posizione = state.posizioneController;
          TextEditingController titoloAlbum = state.titoloAlbumController;
          TextEditingController anno = state.annoController;
          TextEditingController valore = state.valoreController;

          String getIconPath(String? tipologia) {
            switch (tipologia) {
              case '33':
                return 'assets/icons/vinyl-record-blue.png';
              case '45':
                return 'assets/icons/vinyl-record-red.png';
              case '78':
                return 'assets/icons/vinyl-record-violet.png';
              default:
                return 'assets/icons/vinyl-record-blue.png';
            }
          }

          // Funzione per costruire lo stile di InputDecoration con bordo arancione
          InputDecoration buildInputDecoration(String label) {
            return InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                  color: Colors
                      .deepOrangeAccent), // Colore etichetta arancione acceso
              hintStyle: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.6)),
              filled: true,
              fillColor: Theme.of(context)
                  .colorScheme
                  .surface
                  .withOpacity(0.9), // Sfondo più contrastato
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.deepOrangeAccent, // Bordo arancione acceso
                  width: 2, // Leggermente più spesso per renderlo più visibile
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.deepOrangeAccent,
                  width: 2.5, // Bordo più spesso quando è selezionato
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Selezione Tipologia (33, 45, 78) con immagini e etichette
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['33', '45', '78'].map((tipo) {
                    return GestureDetector(
                      onTap: () {
                        context.read<DettaglioDiscoBloc>().add(
                              UpdateTipologiaEvent(
                                tipologia: tipo,
                              ),
                            );
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: state.tipologia == tipo
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2)
                                  : Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: state.tipologia == tipo
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              getIconPath(tipo),
                              width: 80,
                              height: 80,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$tipo giri',
                            style: TextStyle(
                              color: state.tipologia == tipo
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Artista
                TextField(
                  decoration: buildInputDecoration('Artista'),
                  controller: artista,
                  onChanged: (value) {
                    context.read<DettaglioDiscoBloc>().add(
                          UpdateFieldEvent(
                            field: 'artista',
                            value: value,
                          ),
                        );
                  },
                ),
                const SizedBox(height: 16),

                // Posizione
                TextField(
                  decoration: buildInputDecoration('Posizione'),
                  controller: posizione,
                  onChanged: (value) {
                    context.read<DettaglioDiscoBloc>().add(
                          UpdateFieldEvent(
                            field: 'posizione',
                            value: value,
                          ),
                        );
                  },
                ),
                const SizedBox(height: 16),

                // Titolo Album
                TextField(
                  decoration: buildInputDecoration('Titolo Album'),
                  controller: titoloAlbum,
                  onChanged: (value) {
                    context.read<DettaglioDiscoBloc>().add(
                          UpdateFieldEvent(
                            field: 'titoloAlbum',
                            value: value,
                          ),
                        );
                  },
                ),
                const SizedBox(height: 16),

                // Anno
                TextField(
                  decoration: buildInputDecoration('Anno'),
                  controller: anno,
                  onChanged: (value) {
                    context.read<DettaglioDiscoBloc>().add(
                          UpdateFieldEvent(
                            field: 'anno',
                            value: value,
                          ),
                        );
                  },
                ),
                const SizedBox(height: 16),

                // Valore
                TextField(
                  decoration: buildInputDecoration('Valore'),
                  controller: valore,
                  onChanged: (value) {
                    context.read<DettaglioDiscoBloc>().add(
                          UpdateFieldEvent(
                            field: 'valore',
                            value: value,
                          ),
                        );
                  },
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      isSelected: [state.lato == 'A', state.lato == 'B'],
                      onPressed: (index) {
                        context.read<DettaglioDiscoBloc>().add(
                              MostraLatoEvent(lato: index == 0 ? 'A' : 'B'),
                            );
                      },
                      fillColor: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      borderColor: Theme.of(context).colorScheme.primary,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Lato A',
                            style: TextStyle(
                              color: state.lato == 'A'
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
                              color: state.lato == 'B'
                                  ? Colors.deepOrangeAccent
                                  : Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (state.lato == 'A')
                  TextField(
                    decoration: buildInputDecoration('Brano 1'),
                    controller: state.brano1AController,
                    onChanged: (value) {
                      context.read<DettaglioDiscoBloc>().add(
                            UpdateFieldEvent(field: 'brano1A', value: value),
                          );
                    },
                  ),
                if (state.lato == 'B')
                  TextField(
                    decoration: buildInputDecoration('Brano 1'),
                    controller: state.brano1BController,
                    onChanged: (value) {
                      context.read<DettaglioDiscoBloc>().add(
                            UpdateFieldEvent(field: 'brano1B', value: value),
                          );
                    },
                  ),

                const SizedBox(height: 16),

                if (state.tipologia == '33' && state.lato == 'A')
                  Column(
                    children: [
                      TextField(
                        decoration: buildInputDecoration('Brano 2'),
                        controller: state.brano2AController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano2A', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 3'),
                        controller: state.brano3AController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano3A', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 4'),
                        controller: state.brano4AController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano4A', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 5'),
                        controller: state.brano5AController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano5A', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 6'),
                        controller: state.brano6AController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano6A', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 7'),
                        controller: state.brano7AController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano7A', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 8'),
                        controller: state.brano8AController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano8A', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                if (state.tipologia == '33' && state.lato == 'B')
                  Column(
                    children: [
                      TextField(
                        decoration: buildInputDecoration('Brano 2'),
                        controller: state.brano2BController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano2B', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 3'),
                        controller: state.brano3BController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano3B', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 4'),
                        controller: state.brano4BController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano4B', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 5'),
                        controller: state.brano5BController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano5B', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 6'),
                        controller: state.brano6BController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano6B', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 7'),
                        controller: state.brano7BController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano7B', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: buildInputDecoration('Brano 8'),
                        controller: state.brano8BController,
                        onChanged: (value) {
                          context.read<DettaglioDiscoBloc>().add(
                                UpdateFieldEvent(
                                    field: 'brano8B', value: value),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                // for (int i = 0; i < (state.tipologia == '33' ? 8 : 1); i++)
                //   Column(
                //     children: [
                //       TextField(
                //         decoration: buildInputDecoration('Brano ${i + 1}'),
                //         onChanged: (value) {
                //           context.read<DettaglioDiscoBloc>().add(
                //                 UpdateBranoEvent(state.lato, i, value),
                //               );
                //         },
                //       ),
                //       const SizedBox(height: 16),
                //     ],
                //   ),
              ],
            ),
          );
        },
      ),
    );
  }
}
