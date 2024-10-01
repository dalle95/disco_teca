import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '/commons/widgets/dropdown_field.dart';
import '/commons/utils/assets_utils.dart';
import '/commons/entities/disco.dart';

import '/pages/home_page/bloc/home_blocs.dart';
import '/pages/home_page/home_page_controller.dart';
import '/pages/home_page/bloc/home_events.dart';

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
          onPressed: () => controller.paginaProfilo(),
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
    child: ValueListenableBuilder<TextEditingValue>(
      valueListenable: searchController,
      builder: (context, value, child) {
        return TextField(
          controller: searchController,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          decoration: InputDecoration(
            hintText: 'Cerca per album, artista, anno o brano',
            hintStyle: TextStyle(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      searchController.clear();
                      controller.gestisciFiltro('', searchController);
                    },
                  )
                : null,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          onChanged: (value) =>
              controller.gestisciFiltro(value, searchController),
        );
      },
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
      right: 16,
      top: 8.0,
      bottom: 8,
    ),
    child: Row(
      children: [
        // Label "Ordina per" e il DropdownField
        Flexible(
          child: Row(
            children: [
              Text(
                'Ordina per:',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const Gap(16),
              Flexible(
                child: dropDownField(
                  context: context,
                  valore: state.ordering,
                  elenco: ['Artista', 'Titolo', 'Anno', 'Posizione'],
                  onChanged: (value) {
                    controller.ordinaDati(ordering: value!);
                  },
                ),
              ),
            ],
          ),
        ),
        const Gap(15),
        IconButton(
          onPressed: () => state.filtroStrutturatoAttivo
              ? context.read<HomeBloc>().add(HomeInitDatiEvent())
              : controller.paginaFiltro(),
          icon: Icon(
            state.filtroStrutturatoAttivo
                ? Icons.filter_list_off_outlined
                : Icons.filter_list_outlined,
            size: 40,
          ),
        ),
        IconButton(
          icon: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 50,
                child: Icon(
                  Icons.album,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
              ),
              SizedBox(
                height: 50,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 18,
                ),
              ),
            ],
          ),
          onPressed: () => controller.paginaDettaglioDisco(),
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
        controller.paginaDettaglioDisco(arguments: disco.toJson());
      },
    ),
  );
}
