import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/dropdown_field.dart';
import '/common/helper/navigation/app_navigation.dart';
import '/common/helper/assets/assets_utils.dart';
import '/common/widgets/loading_view.dart';
import '/common/widgets/textfield_custom.dart';

import '/core/configs/assets/app_icons.dart';

import '/domain/disco/entities/disco.dart';

import '/presentation/profile/pages/profile_page.dart';
import '/presentation/dettaglio_disco/pages/dettaglio_disco_page.dart';
import '/presentation/home/bloc/dischi_cubit/dischi_cubit.dart';
import '/presentation/home/bloc/dischi_cubit/dischi_state.dart';
import '/presentation/home/bloc/ordine_dischi_cubit.dart';
import '/presentation/home/bloc/search_cubit.dart';
import '/presentation/filtro_dischi/bloc/giri_cubit.dart';
import '/presentation/filtro_dischi/bloc/posizione_cubit.dart';
import '/presentation/filtro_dischi/pages/filtro_dischi_page.dart';

/// Widget per l'appBar
PreferredSizeWidget buildAppBar({
  required BuildContext context,
}) {
  return AppBar(
    title: Text(
      'DiscoTeca',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(),
    ),
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 16),
        child: IconButton(
          icon: Icon(
            Icons.account_circle_rounded,
            color: Theme.of(context).colorScheme.onBackground,
            size: 40,
          ),
          onPressed: () => AppNavigator.push(context, const ProfilePage()),
        ),
      ),
    ],
  );
}

/// Widget per l'input di ricerca dei dischi
class InputRicerca extends StatelessWidget {
  const InputRicerca({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFieldCustom(
        hintText: 'Cerca per album, artista, anno o brano',
        value: context.read<SearchCubit>().state,
        prefixIcon: const Icon(
          Icons.search,
        ),
        onPressed: () {
          context.read<SearchCubit>().updateRicerca('');
          String ordine = context.read<OrdineDischiCubit>().state;
          context.read<DischiCubit>().getDischi(ordine: ordine);
        },
        onChanged: (value) {
          if (value != '') {
            context.read<DischiCubit>().getRicercaDischi(value);
            context.read<SearchCubit>().updateRicerca(value);
          } else {
            String ordine = context.read<OrdineDischiCubit>().state;
            context.read<DischiCubit>().getDischi(ordine: ordine);
          }
        },
      ),
    );
  }
}

/// Widget per la barra di ricerca dei dischi
class BarraOrdinamento extends StatelessWidget {
  const BarraOrdinamento({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 16),
                Flexible(
                  child: BlocBuilder<OrdineDischiCubit, String>(
                    builder: (context, criterio) {
                      return dropDownField(
                        context: context,
                        valore: criterio,
                        elenco: ['Artista', 'Titolo', 'Anno', 'Posizione'],
                        onChanged: (value) {
                          context
                              .read<OrdineDischiCubit>()
                              .cambiaCriterio(value!);
                          context.read<DischiCubit>().ordinaDischi(value);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<PosizioneCubit, String?>(
            builder: (context, posizione) {
              return BlocBuilder<GiriCubit, String?>(
                builder: (context, giri) {
                  return IconButton(
                    onPressed: () {
                      if (giri == null && posizione == null) {
                        AppNavigator.push(
                          context,
                          FiltroDischiPage(),
                        );
                      } else {
                        context.read<GiriCubit>().setGiri(context: context);
                        context
                            .read<PosizioneCubit>()
                            .setPosizione(context: context);
                      }
                    },
                    icon: Icon(
                      (giri == null && posizione == null)
                          ? Icons.filter_list_outlined
                          : Icons.filter_list_off_outlined,
                      size: 40,
                    ),
                  );
                },
              );
            },
          ),
          BlocBuilder<PosizioneCubit, String?>(
            builder: (context, posizione) {
              return BlocBuilder<GiriCubit, String?>(
                builder: (context, giri) {
                  return IconButton(
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
                    onPressed: () async {
                      DiscoEntity disco = DiscoEntity.empty().copyWith(
                        tipologia: giri,
                        posizione: posizione,
                      );

                      AppNavigator.push(
                        context,
                        DettaglioDiscoPage(disco: disco),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ElencoDischi extends StatelessWidget {
  const ElencoDischi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DischiCubit, DischiState>(
      builder: (context, state) {
        if (state is DischiLoading) {
          return const Expanded(
            child: LoadingView(),
          );
        }
        if (state is DischiLoaded) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                String ricerca = context.read<SearchCubit>().state;
                if (ricerca != '') {
                  context
                      .read<DischiCubit>()
                      .getRicercaDischi(context.read<SearchCubit>().state);
                } else {
                  context.read<GiriCubit>().setGiri(context: context);
                  context.read<PosizioneCubit>().setPosizione(context: context);
                }
              },
              child: state.dischi.length == 0
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          physics:
                              const AlwaysScrollableScrollPhysics(), // Permette il refresh anche senza contenuto scrollabile
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Nessun disco...',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Container(
                                  height: 300,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.asset(AppIcons.logo),
                                ),
                                Text(
                                  'Creane subito qualcuno!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: state.dischi.length,
                      itemBuilder: (context, index) {
                        final disco = state.dischi[index];
                        return discoItem(context: context, disco: disco);
                      },
                    ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

/// Widget per definire l'item del disco nell'elenco
Widget discoItem({
  required BuildContext context,
  required dynamic disco,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    color: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 4,
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => AppNavigator.push(context, DettaglioDiscoPage(disco: disco)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
        ),
      ),
    ),
  );
}
