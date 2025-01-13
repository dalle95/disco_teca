import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '/service_locator.dart';
import '/core/usecase/usecase.dart';
import '/domain/foto_disco/repositories/foto_disco.dart';

class UploadImagesToFirebaseUseCase
    extends UseCase<Either, UploadImagesParams> {
  @override
  Future<Either> call({UploadImagesParams? params}) async {
    return await sl<FotoDiscoRepository>().uploadImagesToFirebase(
      params!.discoId,
      params.frontImages,
      params.backImages,
    );
  }
}

class UploadImageData {
  final String? filePath; // Per file locali
  final Uint8List? fileBytes; // Per immagini caricate dal web
  final DateTime timestamp; // Data di caricamento

  UploadImageData({
    this.filePath,
    this.fileBytes,
    required this.timestamp,
  });
}

class UploadImagesParams {
  final String discoId;
  final List<UploadImageData> frontImages;
  final List<UploadImageData> backImages;

  UploadImagesParams({
    required this.discoId,
    required this.frontImages,
    required this.backImages,
  });
}
