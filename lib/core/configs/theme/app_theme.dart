import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/configs/theme/app_colors.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    // Colore primario dell'applicazione
    primaryColor: AppColors.primary,

    // Definizione della schema dei colori di base (per il tema scuro)
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      seedColor: AppColors.primary,
      background: AppColors.background, // Colore di sfondo generale
      surface: AppColors
          .surface, // Colore di sfondo per componenti come Card e TextField
      onBackground: AppColors.onSurface, // Colore del testo sopra il background
      error: Colors.red,
      onError: Colors.white,
    ),

    // Colore di sfondo per tutte le schermate
    scaffoldBackgroundColor: AppColors.background,

    // Tema delle SnackBars
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.background, // Sfondo delle SnackBars
      contentTextStyle:
          TextStyle(color: AppColors.onSurface), // Colore del testo
    ),

    // Stile globale per i campi di input (TextField)
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: AppColors.accent,
      ), // Colore per l'etichetta (label)
      hintStyle: const TextStyle(
        color: AppColors.secondBackground, // Colore del testo segnaposto (hint)
        fontWeight: FontWeight.w400,
      ),
      filled: true, // Imposta i campi come riempiti
      fillColor: AppColors.surface
          .withOpacity(0.9), // Sfondo del TextField per maggiore contrasto
      prefixIconColor: AppColors.accent,
      suffixIconColor: Colors.grey,

      // Configurazione del bordo
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15), // Bordo arrotondato
        borderSide: const BorderSide(
          color: AppColors.surface, // Colore del bordo quando non è attivo
          width: 1,
        ),
      ),

      // Configurazione del bordo abilitato (quando il campo non è in focus)
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.surface,
          width: 1,
        ),
      ),

      // Configurazione del bordo in focus
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.accent,
          width: 2.5, // Bordo più spesso quando è selezionato
        ),
      ),
    ),

    // Tema delle AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background, // Colore di sfondo della AppBar
      foregroundColor:
          AppColors.primary, // Colore dei titoli e delle icone nella AppBar
      elevation: 0, // Rimuove l'ombra della AppBar
    ),

    // Stili di testo utilizzati globalmente
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.primary, // Colore per testi grandi e titoli
      ),
      displayMedium: GoogleFonts.raleway(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white, // Colore per testi medi
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        color: AppColors.secondBackground, // Colore per testi normali
      ),
    ),

    // Stile dei pulsanti elevati (ElevatedButton)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.onSurface, // Colore del testo
        backgroundColor: AppColors.primary, // Colore di sfondo del pulsante
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),

    // Stile delle icone
    iconTheme: const IconThemeData(
      color: AppColors.primary, // Colore principale per le icone
    ),

    // Stile delle card
    cardTheme: const CardTheme(
      color: AppColors.surface, // Colore di sfondo delle card
      elevation: 4, // Ombreggiatura delle card
    ),
  );

  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      primary: AppColors.primary,
      seedColor: AppColors.primary,
      background: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      onBackground: AppColors.lightOnSurface,
      error: Colors.red,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.lightBackground,
      contentTextStyle: TextStyle(color: AppColors.lightOnSurface),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.accent),
      hintStyle: const TextStyle(
        color: AppColors.surface,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: AppColors.lightSurface.withOpacity(0.9),
      prefixIconColor: AppColors.accent,
      suffixIconColor: Colors.grey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.lightSurface,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.lightSurface,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.accent,
          width: 2.5,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.primary,
      elevation: 0,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
      displayMedium: GoogleFonts.raleway(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        color: AppColors.lightOnSurface,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.lightOnSurface,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.primary,
    ),
    cardTheme: const CardTheme(
      color: AppColors.lightSurface,
      elevation: 4,
    ),
  );
}
