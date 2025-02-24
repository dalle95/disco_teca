import 'package:app_disco_teca/presentation/filtro_dischi/bloc/giri_cubit.dart';
import 'package:app_disco_teca/presentation/filtro_dischi/bloc/posizione_cubit.dart';
import 'package:app_disco_teca/presentation/home/bloc/dischi_cubit/dischi_cubit.dart';
import 'package:app_disco_teca/presentation/home/bloc/ordine_dischi_cubit.dart';
import 'package:app_disco_teca/presentation/home/bloc/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/responsive.dart';

import '/presentation/home/widgets/home_widgets.dart';
import '/presentation/home/bloc/dettaglio_disco_desktop_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DischiCubit()),
        BlocProvider(create: (_) => OrdineDischiCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => GiriCubit()),
        BlocProvider(create: (_) => PosizioneCubit()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SearchCubit, String>(
            listener: (context, state) => state.isEmpty
                ? context.read<DischiCubit>().disattivaRicerca()
                : context.read<DischiCubit>().getRicercaDischi(state),
          ),
          BlocListener<OrdineDischiCubit, String>(
            listener: (context, state) =>
                context.read<DischiCubit>().ordinaDischi(state),
          ),
          BlocListener<GiriCubit, String?>(
            listener: (context, state) => state != null
                ? {
                    context.read<SearchCubit>().updateRicerca(''),
                    context.read<DischiCubit>().getFiltraDischi(
                          attributo: AttributoFiltro.giri,
                          parametro: state,
                        )
                  }
                : context.read<DischiCubit>().refreshDischi(),
          ),
          BlocListener<PosizioneCubit, String?>(
            listener: (context, state) => state != null
                ? {
                    context.read<SearchCubit>().updateRicerca(''),
                    context.read<DischiCubit>().getFiltraDischi(
                          attributo: AttributoFiltro.posizione,
                          parametro: state,
                        )
                  }
                : context.read<DischiCubit>().refreshDischi(),
          ),
        ],
        child: Responsive(
          desktop: _buildView(context),
          tablet: _buildView(context),
          mobile: _buildMobileView(context),
        ),
      ),
    );
  }

  /// Builds the desktop and tablet view for the home page with an app bar and a column layout.
  //
  /// The column includes:
  /// - A sorting bar
  /// - A list of records
  ///
  /// The app bar includes a custom app bar with a search field and a button to open the profile page.
  Widget _buildView(BuildContext context) {
    return BlocProvider(
      create: (_) => DettaglioDiscoDesktopCubit(),
      child: Scaffold(
        appBar: buildDesktopAppBar(context: context),
        body: Column(
          children: [
            BarraOrdinamentoDesktop(),
            Expanded(
              child: ElencoDischiDesktop(),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the mobile view for the home page with an app bar and a column layout.
  ///
  /// The column includes:
  /// - An input field for search
  /// - A sorting bar
  /// - A list of records
  Scaffold _buildMobileView(BuildContext context) {
    return Scaffold(
      appBar: buildMobileAppBar(context: context),
      floatingActionButton: AddDiscoButton(),
      body: const Column(
        children: [
          InputRicerca(),
          BarraOrdinamento(),
          ElencoDischi(),
        ],
      ),
    );
  }
}
