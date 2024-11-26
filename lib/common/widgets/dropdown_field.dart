import 'package:flutter/material.dart';

Widget dropDownField({
  required BuildContext context,
  required String? valore,
  required List<String> elenco,
  required void Function(String?) onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
    ),
    child: DropdownButton<String>(
      value: valore,
      isExpanded: true,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      dropdownColor: Theme.of(context).colorScheme.surface,
      underline: const SizedBox(),
      items: elenco.map(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      onChanged: (value) => onChanged(value),
    ),
  );
}
