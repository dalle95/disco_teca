import 'package:disco_teca/pages/dettaglio_disco/bloc/dettaglio_disco_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '/commons/widgets/inputdecoration_textfield.dart';
import '/pages/dettaglio_disco/bloc/dettaglio_disco_bloc.dart';
import '/pages/dettaglio_disco/dettaglio_disco_controller.dart';

PreferredSizeWidget buildAppBar({required BuildContext context}) {
  final controller = DettaglioDiscoController(context: context);

  return AppBar(
    title: const Text('Dettaglio Disco'),
    actions: [
      IconButton(
        onPressed: () {
          controller.aggiornaDettaglio();
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
  );
}

Widget buildSelezioneDisco({required BuildContext context}) {
  final controller = DettaglioDiscoController(context: context);
  final state = context.read<DettaglioDiscoBloc>().state;

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

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: ['33', '45', '78'].map((tipo) {
      return GestureDetector(
        onTap: () => controller.impostaGiri(tipo),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: state.tipologia == tipo
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
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
            const Gap(4),
            Text(
              '$tipo giri',
              style: TextStyle(
                color: state.tipologia == tipo
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget buildSezioneInformazioniDisco({required BuildContext context}) {
  final controller = DettaglioDiscoController(context: context);
  final state = context.read<DettaglioDiscoBloc>().state;

  return Column(
    children: [
      // Artista
      TextField(
        decoration: buildInputDecoration(context: context, label: 'Artista'),
        controller: state.artistaController,
        onChanged: (value) =>
            controller.aggiornaValore(field: 'artista', value: value),
      ),
      const Gap(16),

      // Titolo Album
      TextField(
        decoration:
            buildInputDecoration(context: context, label: 'Titolo Album'),
        controller: state.titoloAlbumController,
        onChanged: (value) =>
            controller.aggiornaValore(field: 'titoloAlbum', value: value),
      ),
      const Gap(16),

      // Selettore Modalità Inserimento Posizione
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Usa posizione esistente?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Switch(
            value: state.isPosizionePresente,
            onChanged: (value) => context.read<DettaglioDiscoBloc>().add(
                  CambiaSetPosizioneEvent(),
                ),
          ),
        ],
      ),
      const Gap(16),

      // Posizione (DropDown o TextField)
      state.isPosizionePresente
          ? DropdownButtonFormField<String>(
              value: state.posizioneController.text.isNotEmpty
                  ? state.posizioneController.text
                  : null,
              decoration:
                  buildInputDecoration(context: context, label: 'Posizione'),
              items: state.listaPosizioni
                  .map<DropdownMenuItem<String>>((posizione) {
                return DropdownMenuItem<String>(
                  value: posizione,
                  child: Text(posizione),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  state.posizioneController.text = value;
                  controller.aggiornaValore(field: 'posizione', value: value);
                }
              },
            )
          : TextField(
              decoration: buildInputDecoration(
                  context: context, label: 'Nuova Posizione'),
              controller: state.posizioneController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'posizione', value: value),
            ),
      const Gap(16),

      // Ordine
      TextField(
        decoration: buildInputDecoration(context: context, label: 'Ordine'),
        controller: state.ordineController,
        onChanged: (value) =>
            controller.aggiornaValore(field: 'ordine', value: value),
      ),
      const Gap(16),

      // Anno
      TextField(
        decoration: buildInputDecoration(context: context, label: 'Anno'),
        controller: state.annoController,
        onChanged: (value) =>
            controller.aggiornaValore(field: 'anno', value: value),
      ),
      const Gap(16),

      // Valore
      TextField(
        decoration: buildInputDecoration(context: context, label: 'Valore'),
        controller: state.valoreController,
        onChanged: (value) =>
            controller.aggiornaValore(field: 'valore', value: value),
      ),
    ],
  );
}

Widget buildSelezioneLatoDisco({required BuildContext context}) {
  final controller = DettaglioDiscoController(context: context);
  final state = context.read<DettaglioDiscoBloc>().state;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ToggleButtons(
        isSelected: [state.lato == 'A', state.lato == 'B'],
        onPressed: (index) => controller.selezionaLato(index),
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
  );
}

Widget buildSezioneBrani({required BuildContext context}) {
  final controller = DettaglioDiscoController(context: context);
  final state = context.read<DettaglioDiscoBloc>().state;
  return Column(
    children: [
      if (state.lato == 'A')
        TextField(
          decoration: buildInputDecoration(context: context, label: 'Brano 1'),
          controller: state.brano1AController,
          onChanged: (value) =>
              controller.aggiornaValore(field: 'brano1A', value: value),
        ),
      if (state.lato == 'B')
        TextField(
          decoration: buildInputDecoration(context: context, label: 'Brano 1'),
          controller: state.brano1BController,
          onChanged: (value) =>
              controller.aggiornaValore(field: 'brano1B', value: value),
        ),
      const SizedBox(height: 16),
      if (state.tipologia == '33' && state.lato == 'A')
        Column(
          children: [
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 2'),
              controller: state.brano2AController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano2A', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 3'),
              controller: state.brano3AController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano3A', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 4'),
              controller: state.brano4AController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano4A', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 5'),
              controller: state.brano5AController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano5A', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 6'),
              controller: state.brano6AController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano6A', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 7'),
              controller: state.brano7AController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano7A', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 8'),
              controller: state.brano8AController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano8A', value: value),
            ),
            const SizedBox(height: 16),
          ],
        ),
      if (state.tipologia == '33' && state.lato == 'B')
        Column(
          children: [
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 2'),
              controller: state.brano2BController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano2B', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 3'),
              controller: state.brano3BController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano3B', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 4'),
              controller: state.brano4BController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano4B', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 5'),
              controller: state.brano5BController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano5B', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 6'),
              controller: state.brano6BController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano6B', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 7'),
              controller: state.brano7BController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano7B', value: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  buildInputDecoration(context: context, label: 'Brano 8'),
              controller: state.brano8BController,
              onChanged: (value) =>
                  controller.aggiornaValore(field: 'brano9B', value: value),
            ),
            const SizedBox(height: 16),
          ],
        ),
    ],
  );
}
