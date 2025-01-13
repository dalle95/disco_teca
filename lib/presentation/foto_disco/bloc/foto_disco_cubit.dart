import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '/service_locator.dart';

import '/domain/foto_disco/entities/foto_disco.dart';
import '/domain/foto_disco/usescases/delete_image.dart';
import '/domain/foto_disco/usescases/load_images.dart';
import '/domain/foto_disco/usescases/upload_images_to_firebase.dart';

class FotoDiscoState {
  final List<ImageData> frontImages;
  final List<ImageData> backImages;
  final String selectedSide;
  final int currentIndex;

  FotoDiscoState({
    this.frontImages = const [],
    this.backImages = const [],
    this.selectedSide = 'Fronte',
    this.currentIndex = 1,
  });

  FotoDiscoState copyWith({
    List<ImageData>? frontImages,
    List<ImageData>? backImages,
    String? selectedSide,
    int? currentIndex,
  }) {
    return FotoDiscoState(
      frontImages: frontImages ?? this.frontImages,
      backImages: backImages ?? this.backImages,
      selectedSide: selectedSide ?? this.selectedSide,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class FotoDiscoCubit extends Cubit<FotoDiscoState> {
  final Logger logger = sl<Logger>();
  final LoadImagesUseCase loadImagesUseCase = sl<LoadImagesUseCase>();
  final DeleteImageUseCase deleteImageUseCase = sl<DeleteImageUseCase>();
  final UploadImagesToFirebaseUseCase uploadImagesToFirebaseUseCase =
      sl<UploadImagesToFirebaseUseCase>();

  String? discoId;
  FotoDiscoCubit(this.discoId) : super(FotoDiscoState()) {
    if (discoId != null) {
      loadImages(discoId!);
    }
  }

  Future<void> loadImages(String discoId) async {
    logger.d('FotoDiscoCubit | Funzione: loadImages');

    final result = await loadImagesUseCase.call(params: discoId);
    result.fold(
      (error) {
        logger.e('Errore durante il caricamento delle immagini: $error');
      },
      (data) {
        final fotoDisco = data as FotoDiscoEntity;
        emit(
          state.copyWith(
            frontImages: fotoDisco.frontImages.map((path) => path).toList(),
            backImages: fotoDisco.backImages.map((path) => path).toList(),
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    logger.d('FotoDiscoCubit | Funzione: pickImage');

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      if (kIsWeb) {
        // Gestione per piattaforma Web
        final Uint8List imageBytes = await pickedFile.readAsBytes();

        if (state.selectedSide == 'Fronte') {
          emit(
            state.copyWith(
              frontImages: List.from(state.frontImages)
                ..add(
                  ImageData(
                    id: null,
                    fileBytes: imageBytes, // Salviamo i byte per Web
                    timestamp: DateTime.now(),
                  ),
                ),
            ),
          );
        } else {
          emit(
            state.copyWith(
              backImages: List.from(state.backImages)
                ..add(
                  ImageData(
                    id: null,
                    fileBytes: imageBytes, // Salviamo i byte per Web
                    timestamp: DateTime.now(),
                  ),
                ),
            ),
          );
        }
      } else {
        // Gestione per piattaforme non web
        final tempDir = await getTemporaryDirectory();
        final tempPath =
            '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final tempFile = await File(pickedFile.path).copy(tempPath);

        if (state.selectedSide == 'Fronte') {
          emit(
            state.copyWith(
              frontImages: List.from(state.frontImages)
                ..add(
                  ImageData(
                    id: null,
                    file: tempFile
                        .path, // Salviamo il file per piattaforme native
                    timestamp: DateTime.now(),
                  ),
                ),
            ),
          );
        } else {
          emit(
            state.copyWith(
              backImages: List.from(state.backImages)
                ..add(
                  ImageData(
                    id: null,
                    file: tempFile
                        .path, // Salviamo il file per piattaforme native
                    timestamp: DateTime.now(),
                  ),
                ),
            ),
          );
        }
      }
    }
  }

  void toggleSide(String side) {
    logger.d('FotoDiscoCubit | Funzione: toggleSide');

    emit(
      state.copyWith(selectedSide: side, currentIndex: 1),
    );
  }

  Future<void> deleteImage() async {
    logger.d('FotoDiscoCubit | Funzione: deleteImage');

    logger.d(state.currentIndex);
    logger.d(state.selectedSide.toLowerCase());

    final side = state.selectedSide.toLowerCase();
    final imageData = side == 'fronte'
        ? state.frontImages[state.currentIndex - 1]
        : state.backImages[state.currentIndex - 1];

    if (imageData.id == null) {
      final updatedImages = side == 'fronte'
          ? state.frontImages
              .where((img) => img.file != imageData.file)
              .toList()
          : state.backImages
              .where((img) => img.file != imageData.file)
              .toList();

      emit(
        state.copyWith(
          frontImages: side == 'fronte' ? updatedImages : state.frontImages,
          backImages: side == 'retro' ? updatedImages : state.backImages,
        ),
      );
    } else {
      String imageId = imageData.id!;
      final result = await deleteImageUseCase.call(
        params: DeleteImageParams(
          discoId: discoId!,
          side: side,
          imageId: imageId,
        ),
      );

      result.fold(
        (error) => logger.e('Errore durante l\'eliminazione: $error'),
        (_) {
          final updatedImages = side == 'fronte'
              ? state.frontImages.where((img) => img.id != imageId).toList()
              : state.backImages.where((img) => img.id != imageId).toList();

          emit(
            state.copyWith(
              frontImages: side == 'fronte' ? updatedImages : state.frontImages,
              backImages: side == 'retro' ? updatedImages : state.backImages,
            ),
          );
        },
      );
    }
  }

  void setCurrentIndex(int index) {
    logger.d('FotoDiscoCubit | Funzione: setCurrentIndex');
    emit(
      state.copyWith(currentIndex: index + 1),
    );
  }

  Future<void> uploadImagesToFirebase(String discoId) async {
    logger.d('FotoDiscoCubit | Funzione: uploadImagesToFirebase');

    // Filtra le immagini senza ID (nuove immagini da caricare)
    final frontImagesToUpload =
        state.frontImages.where((image) => image.id == null).toList();
    final backImagesToUpload =
        state.backImages.where((image) => image.id == null).toList();

    logger.d(
        'Front Images: ${frontImagesToUpload.length}, Back Images: ${backImagesToUpload.length}');

    // Mappa i file o fileBytes per l'upload
    final frontImages = frontImagesToUpload.map((image) {
      if (image.fileBytes != null) {
        return UploadImageData(
          fileBytes: image.fileBytes!,
          timestamp: image.timestamp,
        );
      } else if (image.file != null) {
        return UploadImageData(
          filePath: image.file!,
          timestamp: image.timestamp,
        );
      } else {
        throw Exception('Immagine non valida: file e fileBytes nulli');
      }
    }).toList();

    final backImages = backImagesToUpload.map((image) {
      if (image.fileBytes != null) {
        return UploadImageData(
          fileBytes: image.fileBytes!,
          timestamp: image.timestamp,
        );
      } else if (image.file != null) {
        return UploadImageData(
          filePath: image.file!,
          timestamp: image.timestamp,
        );
      } else {
        throw Exception('Immagine non valida: file e fileBytes nulli');
      }
    }).toList();

    // Chiama il caso d'uso per caricare le immagini su Firebase
    final result = await uploadImagesToFirebaseUseCase.call(
      params: UploadImagesParams(
        discoId: discoId,
        frontImages: frontImages,
        backImages: backImages,
      ),
    );

    result.fold(
      (error) {
        logger.e(
            'Errore durante il caricamento delle immagini su Firebase: $error');
      },
      (data) {
        logger.d('Caricamento completato');
      },
    );
  }

  Future<void> deleteAllImages() async {
    logger.d('FotoDiscoCubit | Funzione: deleteAllImages');

    // Salva una copia delle immagini corrente
    final frontImages = List<ImageData>.from(state.frontImages);
    final backImages = List<ImageData>.from(state.backImages);

    // Gestisce l'eliminazione per le immagini fronte
    for (int i = 0; i < frontImages.length; i++) {
      emit(state.copyWith(
        selectedSide: 'Fronte',
        currentIndex: i + 1, // Imposta l'indice corrente
      ));
      await deleteImage();
    }

    // Gestisce l'eliminazione per le immagini retro
    for (int i = 0; i < backImages.length; i++) {
      emit(state.copyWith(
        selectedSide: 'Retro',
        currentIndex: i + 1, // Imposta l'indice corrente
      ));
      await deleteImage();
    }

    logger.d('Tutte le immagini sono state eliminate.');
  }
}
