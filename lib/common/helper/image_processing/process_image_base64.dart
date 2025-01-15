import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:image/image.dart' as img;

Future<List<String>> processImagesToBase64({
  required List<dynamic> images, // Lista di percorsi (String) o Uint8List
  int width = 512,
  int height = 512,
  int quality = 75,
}) async {
  List<String> base64Images = [];

  for (var image in images) {
    try {
      img.Image? originalImage;

      if (image is String) {
        // Se l'immagine è un percorso file
        final fileBytes = File(image).readAsBytesSync();
        originalImage = img.decodeImage(fileBytes);
      } else if (image is Uint8List) {
        // Se l'immagine è un Uint8List
        originalImage = img.decodeImage(image);
      } else {
        throw Exception('Formato immagine non supportato: $image');
      }

      if (originalImage == null) {
        throw Exception('Impossibile decodificare l\'immagine');
      }

      // Ridimensiona l'immagine a 512x512
      final resizedImage =
          img.copyResize(originalImage, width: width, height: height);

      // Converti in JPEG con qualità specificata
      final jpegImage = img.encodeJpg(resizedImage, quality: quality);

      // Codifica l'immagine in Base64
      final base64String = base64Encode(jpegImage);

      // Aggiungi l'immagine codificata alla lista
      base64Images.add(base64String);
    } catch (e) {
      print('Errore durante la trasformazione dell\'immagine: $e');
    }
  }

  return base64Images;
}
