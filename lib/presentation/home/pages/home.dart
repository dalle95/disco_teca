import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/responsive.dart';

import '/presentation/home/widgets/home_widgets.dart';
import '/presentation/home/bloc/dischi_cubit/dischi_cubit.dart';
import '/presentation/home/bloc/dettaglio_disco_desktop_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DischiCubit>().getDischi();
    return Responsive(
      desktop: _buildView(context),
      tablet: _buildView(context),
      mobile: _buildMobileView(context),
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
