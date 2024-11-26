import 'package:app_disco_teca/common/helper/assets/assets_utils.dart';
import 'package:flutter/material.dart';

Widget buildSelezioneDisco({
  required BuildContext context,
  required void Function(String) onTap,
  String? tipologia,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: ['33', '45', '78', 'CD'].map(
      (tipo) {
        return GestureDetector(
          onTap: () => onTap(tipo),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: tipologia == tipo
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: tipologia == tipo
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  getIconPath(tipo),
                  width: 60,
                  height: 60,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tipo == 'CD' ? tipo : '$tipo giri',
                style: TextStyle(
                  color: tipologia == tipo
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    ).toList(),
  );
}
