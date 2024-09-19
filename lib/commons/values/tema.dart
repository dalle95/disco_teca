import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final tema = ThemeData(
  // Colori principali
  primaryColor: const Color(0xFFFF5722), // Arancione vibrante
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFF5722), // Arancione vibrante
    primary: const Color(0xFFFF5722), // Arancione vibrante
    secondary: const Color(0xFF4DB6AC), // Turchese chiaro
    background: const Color(0xFF282828), // Grigio antracite
    surface: const Color(0xFF3D3D3D), // Grigio più chiaro per la surface
    onSurface: Colors.white, // Colore per il testo su superfici
    onBackground: const Color(0xFFE0E0E0), // Grigio chiaro
    surfaceTint: Colors.white, // Tinta della superficie
  ),

  // Sfondo dell'app
  scaffoldBackgroundColor: const Color(0xFF282828), // Grigio antracite

  // Stili di testo
  textTheme: TextTheme(
    displayLarge: GoogleFonts.montserrat(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFF5722), // Arancione vibrante
    ),
    displayMedium: GoogleFonts.raleway(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16,
      color: const Color(0xFFE0E0E0), // Grigio chiaro
    ),
  ),

  // Stile dei pulsanti
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFFFF5722),
    ),
  ),

  // Stile delle AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF282828), // Grigio antracite
    foregroundColor: Color(0xFFFF5722), // Arancione vibrante
    elevation: 0,
  ),

  // Stile delle icone
  iconTheme: const IconThemeData(
    color: Color(0xFFFF5722), // Arancione vibrante
  ),

  // Stile delle card
  cardTheme: const CardTheme(
    color: Color(0xFF3D3D3D), // Grigio più chiaro per le card
    elevation: 4,
  ),
);
