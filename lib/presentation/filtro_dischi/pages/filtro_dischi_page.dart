import 'package:flutter/material.dart';

import '/common/widgets/responsive.dart';
import '/common/widgets/appbar/app_bar.dart';

import '/presentation/filtro_dischi/widgets/filtro_dischi_widgets.dart';

class FiltroDischiPage extends StatelessWidget {
  const FiltroDischiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(title: 'Filtro Dischi'),
      body: Responsive(
        desktop: _buildDesktopView(),
        tablet: _buildDesktopView(),
        mobile: _buildView(),
      ),
    );
  }

  Widget _buildView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selezione Tipologia (33, 45, 78) con immagini e etichette
          SezioneDisco(),
          // Selezione Posizione con elenco a tendina
          SezionePosizione(),
        ],
      ),
    );
  }

  Widget _buildDesktopView() {
    return Center(
      child: Container(
        width: 600,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selezione Tipologia (33, 45, 78) con immagini e etichette
            SezioneDisco(),
            // Selezione Posizione con elenco a tendina
            SezionePosizione(),
          ],
        ),
      ),
    );
  }
}
