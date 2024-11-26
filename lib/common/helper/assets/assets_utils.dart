// Definire il percorso dell'immagine in base alla tipologia del disco
import 'package:app_disco_teca/core/configs/assets/app_gifs.dart';

import '/core/configs/assets/app_icons.dart';

String getIconPath(String? tipologia) {
  switch (tipologia) {
    case '33':
      return AppIcons.discoBlu;
    case '45':
      return AppIcons.discoRosso;
    case '78':
      return AppIcons.discoViola;
    case 'CD':
      return AppIcons.discoCD;
    default:
      return AppIcons
          .discoBlu; // Icona predefinita in caso di valore non valido
  }
}

String getLoadingGifPath() {
  return AppGifs.discoGirante;
}
