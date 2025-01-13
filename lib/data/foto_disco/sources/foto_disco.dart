import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/foto_disco/entities/foto_disco.dart';
import '/domain/foto_disco/usescases/upload_images_to_firebase.dart';

abstract class FotoDiscoService {
  // Per gestire i log
  final logger = sl<Logger>();

  Future<Either> loadImages(String discoId);
  Future<Either> deleteImage(
    String discoId,
    String side,
    String imageId,
  );
  Future<Either> uploadImagesToFirebase(
    String discoId,
    List<UploadImageData> frontImages,
    List<UploadImageData> backImages,
  );
}

class FotoDiscoApiServiceImpl extends FotoDiscoService {
  final FirebaseStorage _storage = sl<FirebaseStorage>();
  final FirebaseFirestore _firestore = sl<FirebaseFirestore>();

  @override
  Future<Either> loadImages(String discoId) async {
    logger.d("FotoDiscoApiServiceImpl | Funzione: loadImages");

    try {
      final frontImagesSnapshot =
          await _firestore.collection('dischi/$discoId/immaginiFronte').get();
      final backImagesSnapshot =
          await _firestore.collection('dischi/$discoId/immaginiRetro').get();

      final frontImages = frontImagesSnapshot.docs.map((doc) {
        final data = doc.data();
        return ImageData(
          id: doc.id,
          file: data['path'],
          timestamp: DateTime.parse(
              data['timestamp']), // Converte la stringa ISO 8601 in DateTime
        );
      }).toList();

      final backImages = backImagesSnapshot.docs.map((doc) {
        final data = doc.data();
        return ImageData(
          id: doc.id,
          file: data['path'],
          timestamp: DateTime.parse(
              data['timestamp']), // Converte la stringa ISO 8601 in DateTime
        );
      }).toList();

      final fotoDisco = FotoDiscoEntity(
        frontImages: frontImages,
        backImages: backImages,
      );

      return Right(fotoDisco);
    } catch (e) {
      logger.e('Errore durante il caricamento delle immagini: $e');
      return Left(e);
    }
  }

  @override
  Future<Either> deleteImage(
    String discoId,
    String side,
    String imageId,
  ) async {
    logger.d("FotoDiscoApiServiceImpl | Funzione: deleteImage");

    try {
      final collectionPath = 'dischi/$discoId/immagini${side.capitalize()}';
      final docRef = _firestore.collection(collectionPath).doc(imageId);

      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        return Left('Documento non trovato');
      }

      final path = docSnapshot.data()!['path'] as String;
      final ref = _storage.refFromURL(path);

      await ref.delete(); // Elimina dal Firebase Storage
      await docRef.delete(); // Elimina dal Firestore

      return Right(true);
    } catch (e) {
      logger.e('Errore durante l\'eliminazione dell\'immagine: $e');
      return Left(e);
    }
  }

  @override
  Future<Either> uploadImagesToFirebase(
    String discoId,
    List<UploadImageData> frontImages,
    List<UploadImageData> backImages,
  ) async {
    logger.d("FotoDiscoApiServiceImpl | Funzione: uploadImagesToFirebase");

    Future<void> _uploadImages(
      List<UploadImageData> images,
      String side,
    ) async {
      final collectionPath = 'dischi/$discoId/immagini${side.capitalize()}';

      for (var imageData in images) {
        final imageId = DateTime.now().millisecondsSinceEpoch.toString();
        final path = 'dischi/$discoId/$side/$imageId.jpg';

        try {
          // Salvataggio su Firebase Storage
          final ref = _storage.ref().child(path);

          if (imageData.fileBytes != null) {
            // Upload tramite fileBytes (per il web)
            await ref.putData(imageData.fileBytes!);
          } else if (imageData.filePath != null) {
            // Upload tramite filePath (per il mobile)
            final file = File(imageData.filePath!);
            await ref.putFile(file);
          } else {
            throw Exception(
                'Dati immagine non validi: filePath e fileBytes nulli');
          }

          // Ottieni l'URL di download
          final downloadUrl = await ref.getDownloadURL();

          // Salvataggio su Firestore
          await _firestore.collection(collectionPath).doc(imageId).set({
            'path': downloadUrl,
            'timestamp': imageData.timestamp.toIso8601String(),
          });
        } catch (e) {
          logger
              .e('Errore durante l\'upload dell\'immagine con ID $imageId: $e');
          rethrow;
        }
      }
    }

    try {
      // Carica le immagini fronte e retro
      await _uploadImages(frontImages, 'fronte');
      await _uploadImages(backImages, 'retro');
      logger.d('Caricamento completato');
      return Right(true);
    } catch (e) {
      logger.e('Errore durante il caricamento delle immagini: $e');
      return Left(e);
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}
