import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '/commons/utils/assets_utils.dart';
import '/commons/entities/disco.dart';

import '/pages/home_page/bloc/home_blocs.dart';
import '/pages/home_page/home_page_controller.dart';

/// Widget per l'appBar
PreferredSizeWidget buildAppBar({
  required BuildContext context,
}) {
  var controller = HomePageController(context: context);

  return AppBar(
    title: Text(
      'DiscoTeca',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    ),
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 16),
        child: IconButton(
          icon: Icon(
            Icons.account_circle_rounded,
            color: Theme.of(context).colorScheme.onBackground,
            size: 40,
          ),
          onPressed: () => controller.profileDialog(),
        ),
      ),
    ],
  );
}

// Widget per la ricerca dei dischi
Widget buildInputRicerca({
  required BuildContext context,
  required TextEditingController searchController,
}) {
  var controller = HomePageController(context: context);

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      controller: searchController,
      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      decoration: InputDecoration(
        hintText: 'Cerca per album, artista, anno o brano',
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
        prefixIcon:
            Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      onChanged: (value) => controller.gestisciFiltro(value, searchController),
    ),
  );
}

/// Widget per la barra di ricerca dei dischi
Widget buildBarraOrdinamento({
  required BuildContext context,
}) {
  var state = context.read<HomeBloc>().state;
  var controller = HomePageController(context: context);

  return Padding(
    padding: const EdgeInsets.only(
      left: 16.0,
      top: 8.0,
      bottom: 8,
    ),
    child: Row(
      children: [
        Text(
          'Ordina per:',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: state.ordering,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            dropdownColor: Theme.of(context).colorScheme.surface,
            underline: const SizedBox(),
            items:
                ['Artista', 'Titolo', 'Anno', 'Posizione'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              controller.ordinaDati(ordering: value!);
            },
          ),
        ),
        const Gap(15),
        // Expanded(
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.filter_list_outlined,
        //       size: 40,
        //     ),
        //   ),
        // ),
        Expanded(
          child: IconButton(
            icon: Stack(
              alignment: Alignment.center, // Posiziona il + al centro del disco
              children: [
                SizedBox(
                  height: 50,
                  child: Icon(
                    Icons.album, // Icona del disco
                    color: Theme.of(context).colorScheme.primary,
                    size: 40, // Dimensione maggiore per il disco
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground, // Colore diverso per il +
                    size:
                        18, // Dimensione del + per farlo entrare nel buco del disco
                  ),
                ),
              ],
            ),
            onPressed: () => controller.paginaDettaglio(),
          ),
        ),
      ],
    ),
  );
}

Widget buildElencoDischi({
  required BuildContext context,
}) {
  var state = context.read<HomeBloc>().state;
  var controller = HomePageController(context: context);

  return Expanded(
    child: RefreshIndicator(
      onRefresh: () => controller.estraiDati(),
      child: ListView.builder(
        itemCount: state.lista.length,
        itemBuilder: (context, index) {
          final disco = state.lista[index];
          return discoItem(context: context, disco: disco);
        },
      ),
    ),
  );
}

/// Widget per definire l'item del disco nell'elenco
Widget discoItem({
  required BuildContext context,
  required Disco disco,
}) {
  var controller = HomePageController(context: context);

  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    color: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 4,
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      title: Text(
        disco.artista!,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      subtitle: Text(
        '${disco.titoloAlbum} - ${disco.anno}',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      leading: Image.asset(
        getIconPath(
          disco.giri,
        ), // Seleziona l'icona giusta in base alla tipologia
        width: 48,
        height: 48,
      ),
      trailing: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ordine',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
              ),
            ),
            Text(
              disco.ordine == null ? 'Nessuno' : disco.ordine.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        controller.paginaDettaglio(arguments: disco.toJson());
      },
    ),
  );
}
