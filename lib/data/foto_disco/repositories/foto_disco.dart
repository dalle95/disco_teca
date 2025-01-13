import 'package:app_disco_teca/domain/foto_disco/usescases/upload_images_to_firebase.dart';
import 'package:dartz/dartz.dart';

import '/service_locator.dart';
import '/data/foto_disco/sources/foto_disco.dart';
import '/domain/foto_disco/repositories/foto_disco.dart';

class FotoDiscoRepositoryImpl extends FotoDiscoRepository {
  @override
  Future<Either> loadImages(String discoId) async {
    logger.d("FotoDiscoRepositoryImpl | Funzione: loadImages");

    // Chiama il metodo del servizio per caricare le immagini
    var data = await sl<FotoDiscoService>().loadImages(discoId);
    return data.fold(
      (error) {
        logger.e("Errore durante il caricamento delle immagini: $error");
        return Left(error);
      },
      (data) {
        logger.d("Immagini caricate correttamente");
        return Right(data);
      },
    );
  }

  @override
  Future<Either> deleteImage(
      String discoId, String side, String imageId) async {
    logger.d("FotoDiscoRepositoryImpl | Funzione: deleteImage");

    // Chiama il metodo del servizio per eliminare un'immagine specifica
    var data = await sl<FotoDiscoService>().deleteImage(discoId, side, imageId);
    return data.fold(
      (error) {
        logger.e("Errore durante l'eliminazione dell'immagine: $error");
        return Left(error);
      },
      (success) {
        logger.d("Immagine eliminata correttamente con ID: $imageId");
        return Right(success);
      },
    );
  }

  @override
  Future<Either> uploadImagesToFirebase(
    String discoId,
    List<UploadImageData> frontImages,
    List<UploadImageData> backImages,
  ) async {
    logger.d("FotoDiscoRepositoryImpl | Funzione: uploadImagesToFirebase");

    // Chiama il metodo del servizio per caricare più immagini
    var data = await sl<FotoDiscoService>().uploadImagesToFirebase(
      discoId,
      frontImages,
      backImages,
    );
    return data.fold(
      (error) {
        logger.e("Errore durante il caricamento delle immagini: $error");
        return Left(error);
      },
      (data) {
        logger.d("Immagini caricate correttamente");
        return Right(data);
      },
    );
  }
}
