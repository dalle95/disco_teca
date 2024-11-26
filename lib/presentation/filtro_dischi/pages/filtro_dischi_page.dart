import 'package:flutter/material.dart';

import '/common/widgets/appbar/app_bar.dart';

import '/presentation/filtro_dischi/widgets/filtro_dischi_widgets.dart';

class FiltroDischiPage extends StatelessWidget {
  const FiltroDischiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(title: 'Filtro Dischi'),
      body: Padding(
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
      ),
    );
  }
}
