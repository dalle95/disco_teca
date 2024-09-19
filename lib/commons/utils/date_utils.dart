import 'package:intl/intl.dart';

/// Funzioni di aiuto per le date
class DateHelpers {
  /// Funzione per definire i giorni di un mese da una data
  int giorniNelMese(DateTime data) {
    final firstDayThisMonth = DateTime(data.year, data.month, 1);
    final firstDayNextMonth =
        DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, 1);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  /// Restituisce l'ultimo giorno del mese precedente
  DateTime ultimoGiornoDelMesePrecedente(DateTime date) {
    return DateTime(date.year, date.month, 0);
  }

  /// Funzione per estrarre il primo giorno del mese
  DateTime primoGiornoDelMese(DateTime data) {
    return DateTime(data.year, data.month, 1);
  }

  /// Funzione per estrarre il lunedì della settimana da una data
  DateTime primoGiornoDellaSettimana(DateTime data) {
    return data.subtract(Duration(days: data.weekday - 1));
  }

  /// Funzione per diminuire di un mese una data
  DateTime menoUnMese(DateTime data) =>
      DateTime(data.year, data.month - 1, data.day);

  /// Funzione per aumentare di un mese una data
  DateTime piuUnMese(DateTime data) =>
      DateTime(data.year, data.month + 1, data.day);

  /// Funzione per aumentare/diminuire una data di una settimana predendo sempre lunedì come riferimento
  DateTime definisciSettimana(
    DateTime date,
    String funzione,
  ) {
    // Trova il lunedì della settimana della data fornita
    DateTime monday = date.subtract(Duration(days: date.weekday - 1));

    // Aggiungi o sottrai una settimana
    if (funzione == "add") {
      monday = monday.add(const Duration(days: 7));
    } else {
      monday = monday.subtract(const Duration(days: 7));
    }

    return monday;
  }

  /// Formattazione data DateTime in data Stringa
  String dataFormattata(DateTime data) {
    return DateFormat('dd/MM/yyyy').format(data);
  }

  /// Formattazione data DateTime in data Stringa "Mese anno"
  String dataFormattataMeseAnno(DateTime data) {
    return DateFormat('MMMM yyyy', 'it_IT').format(data);
  }

  /// Casta data DateTime senza ora e minuti
  DateTime castSenzaOra(DateTime data) {
    return DateTime(
      data.year,
      data.month,
      data.day,
    );
  }

  /// Funzione per sapere se 2 date sono lo stesso giorno
  bool stessoGiorno(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
