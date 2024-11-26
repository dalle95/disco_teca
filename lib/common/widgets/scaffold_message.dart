import 'package:flutter/material.dart';

// Funzione per visualizzare il messaggio nella SnackBar
void showScaffoldMessage({
  required BuildContext context,
  required String message,
}) {
  final messenger = ScaffoldMessenger.of(context);

  messenger.clearSnackBars(); // Opzionale: rimuove eventuali messaggi attivi
  messenger.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2), // Durata del messaggio
      action: SnackBarAction(
        label: 'OK', // Testo del pulsante (opzionale)
        onPressed: () {
          // Azione da eseguire quando si clicca su 'OK' (opzionale)
          messenger.hideCurrentSnackBar(); // Nasconde il messaggio
        },
      ),
    ),
  );
}
