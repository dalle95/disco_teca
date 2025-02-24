import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/dropdown_field.dart';
import '/common/helper/navigation/app_navigation.dart';
import '/common/widgets/loading_view.dart';
import '/common/widgets/textfield_custom.dart';
import '/common/widgets/responsive.dart';

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
import '/presentation/home/bloc/dettaglio_disco_desktop_cubit.dart';
import '/presentation/home/widgets/disco_item.dart';

/// Widget per l'appBar
PreferredSizeWidget buildMobileAppBar({
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

PreferredSizeWidget buildDesktopAppBar({
  required BuildContext context,
}) {
  return AppBar(
    title: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'DiscoTeca',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(),
            ),
          ),
          SizedBox(
            width: 450,
            height: 80,
            child: InputRicerca(),
          ),
          Spacer(),
        ],
      ),
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
      child: BlocBuilder<SearchCubit, String>(
        builder: (context, state) {
          return TextFieldCustom(
            hintText: 'Cerca per album, artista, anno o brano',
            value: state,
            prefixIcon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              context.read<SearchCubit>().updateRicerca('');

              DettaglioDiscoDesktopCubit? desktopCubit;
              try {
                desktopCubit = context.read<DettaglioDiscoDesktopCubit>();
              } catch (_) {
                desktopCubit = null;
              }

              if (desktopCubit != null) {
                desktopCubit.setNessunDisco();
              }
            },
            onChanged: (value) {
              context.read<SearchCubit>().updateRicerca(value);
            },
          );
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
                const SizedBox(width: 10),
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
                          MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                  value: context.read<GiriCubit>()),
                              BlocProvider.value(
                                  value: context.read<PosizioneCubit>()),
                            ],
                            child: FiltroDischiPage(),
                          ),
                        );
                      } else {
                        context.read<GiriCubit>().setGiri();
                        context.read<PosizioneCubit>().setPosizione();
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
        ],
      ),
    );
  }
}

class AddDiscoButton extends StatelessWidget {
  const AddDiscoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosizioneCubit, String?>(
      builder: (context, posizione) {
        return BlocBuilder<GiriCubit, String?>(
          builder: (context, giri) {
            return IconButton(
              color: Theme.of(context).colorScheme.primary,
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 25,
                  ),
                  Icon(
                    Icons.album,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 30,
                  ),
                  Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 15,
                  ),
                ],
              ),
              onPressed: () async {
                int ordine = await context
                    .read<DischiCubit>()
                    .getOrdinePosizione(posizione: posizione);
                DiscoEntity disco = DiscoEntity().copyWith(
                  tipologia: giri,
                  posizione: posizione,
                  ordine: ordine,
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
    );
  }
}

class BarraOrdinamentoDesktop extends StatelessWidget {
  const BarraOrdinamentoDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
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
            flex: 1,
            child: Row(
              children: [
                Text(
                  'Ordina per:',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const SizedBox(width: 10),
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
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<DischiCubit>().refreshDischi();
                    context.read<GiriCubit>().setGiri();
                    context.read<PosizioneCubit>().setPosizione();
                    context.read<DettaglioDiscoDesktopCubit>().setNessunDisco();
                    context.read<SearchCubit>().updateRicerca('');
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
                BlocBuilder<PosizioneCubit, String?>(
                  builder: (context, posizione) {
                    return BlocBuilder<GiriCubit, String?>(
                      builder: (context, giri) {
                        return IconButton(
                          onPressed: () {
                            if (giri == null && posizione == null) {
                              AppNavigator.push(
                                context,
                                MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                        value: context.read<GiriCubit>()),
                                    BlocProvider.value(
                                        value: context.read<PosizioneCubit>()),
                                  ],
                                  child: FiltroDischiPage(),
                                ),
                              );
                            } else {
                              context.read<GiriCubit>().setGiri();
                              context.read<PosizioneCubit>().setPosizione();
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            int ordine = await context
                                .read<DischiCubit>()
                                .getOrdinePosizione(posizione: posizione);
                            DiscoEntity disco = DiscoEntity().copyWith(
                              tipologia: giri,
                              posizione: posizione,
                              ordine: ordine,
                            );

                            if (isMobile) {
                              AppNavigator.push(
                                context,
                                DettaglioDiscoPage(disco: disco),
                              );
                            } else {
                              context
                                  .read<DettaglioDiscoDesktopCubit>()
                                  .setDisco(disco);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ElencoDischi extends StatelessWidget {
  const ElencoDischi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DischiCubit, DischiCubitState>(
      builder: (context, state) {
        // 1) Check loading
        if (state.isLoading) {
          return const Expanded(
            child: LoadingView(),
          );
        }

        // 2) Check error
        if (state.errorMessage != null) {
          return Expanded(
            child: Center(
              child: Text(
                'Errore: ${state.errorMessage}',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          );
        }

        // 3) If not loading and no error, show data
        final dischiFiltrati = state.dischiFiltrati;
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<SearchCubit>().updateRicerca('');
              context.read<GiriCubit>().setGiri();
              context.read<PosizioneCubit>().setPosizione();
            },
            child: dischiFiltrati.isEmpty
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Nessun disco...',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
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
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: dischiFiltrati.length,
                    itemBuilder: (context, index) {
                      final disco = dischiFiltrati[index];
                      return DiscoItem(context: context, disco: disco);
                    },
                  ),
          ),
        );
      },
    );
  }
}

class ElencoDischiDesktop extends StatelessWidget {
  const ElencoDischiDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DischiCubit, DischiCubitState>(
      builder: (context, state) {
        // 1) Check loading
        if (state.isLoading) {
          return const Expanded(
            child: LoadingView(),
          );
        }

        // 2) Check error
        if (state.errorMessage != null) {
          return Expanded(
            child: Center(
              child: Text(
                'Errore: ${state.errorMessage}',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          );
        }

        // 3) If not loading and no error, show data
        final dischiFiltrati = state.dischiFiltrati;
        return Row(
          children: [
            Expanded(
              child: dischiFiltrati.isEmpty
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Nessun disco...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
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
                      itemCount: dischiFiltrati.length,
                      itemBuilder: (context, index) {
                        final disco = dischiFiltrati[index];
                        return DiscoItem(context: context, disco: disco);
                      },
                    ),
            ),
            Expanded(
              child: BlocBuilder<DettaglioDiscoDesktopCubit, DiscoEntity?>(
                builder: (context, disco) {
                  if (disco == null) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Seleziona un disco per visualizzare i dettagli",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.only(right: 8),
                    child: DettaglioDiscoPage(
                      disco: disco,
                      key: ValueKey(disco.id),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
