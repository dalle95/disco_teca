import 'package:flutter/material.dart';

// Funzione per costruire lo stile di InputDecoration con bordo arancione
InputDecoration buildInputDecoration({
  required BuildContext context,
  required String label,
}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(
        color: Colors.deepOrangeAccent), // Colore etichetta arancione acceso
    hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
    filled: true,
    fillColor: Theme.of(context)
        .colorScheme
        .surface
        .withOpacity(0.9), // Sfondo più contrastato
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.deepOrangeAccent, // Bordo arancione acceso
        width: 2, // Leggermente più spesso per renderlo più visibile
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.deepOrangeAccent,
        width: 2.5, // Bordo più spesso quando è selezionato
      ),
    ),
  );
}
