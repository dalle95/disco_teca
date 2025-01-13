import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/foto_disco/usescases/upload_images_to_firebase.dart';

abstract class FotoDiscoRepository {
  // Per gestire i log
  final logger = sl<Logger>();

  Future<Either> loadImages(String discoId);
  Future<Either> deleteImage(String discoId, String side, String imageId);
  Future<Either> uploadImagesToFirebase(
    String discoId,
    List<UploadImageData> frontImages,
    List<UploadImageData> backImages,
  );
}
