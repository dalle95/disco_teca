import 'dart:typed_data';

class ImageData {
  final String? id;
  final String? file; // URL o path locale
  final Uint8List? fileBytes; // Byte dell'immagine (per il web)
  final DateTime timestamp;

  ImageData({
    this.id,
    this.file,
    this.fileBytes,
    required this.timestamp,
  });
}

class FotoDiscoEntity {
  final List<ImageData> frontImages;
  final List<ImageData> backImages;

  FotoDiscoEntity({
    required this.frontImages,
    required this.backImages,
  });
}
