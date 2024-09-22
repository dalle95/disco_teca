// Definire il percorso dell'immagine in base alla tipologia del disco
String getIconPath(String? tipologia) {
  switch (tipologia) {
    case '33':
      return 'assets/icons/vinyl-record-blue.png';
    case '45':
      return 'assets/icons/vinyl-record-red.png';
    case '78':
      return 'assets/icons/vinyl-record-violet.png';
    default:
      return 'assets/icons/vinyl-record-blue.png'; // Icona predefinita in caso di valore non valido
  }
}

String getLoadingGifPath() {
  return 'assets/gifs/spinning-vinyl.gif';
}
