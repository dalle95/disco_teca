import 'package:flutter/material.dart';

import '/commons/values/colors.dart';

/// Costrutto per la sezione filtri
Widget buildFiltro({
  bool? filtroAttivo,
  void Function()? disattivaFiltro,
  void Function()? attivaFiltro,
}) {
  return IconButton(
    color: AppColors.iconColor,
    iconSize: 30,
    onPressed: filtroAttivo! ? disattivaFiltro : attivaFiltro,
    icon: Icon(
      filtroAttivo ? Icons.filter_alt_off_rounded : Icons.filter_alt_rounded,
    ),
  );
}
