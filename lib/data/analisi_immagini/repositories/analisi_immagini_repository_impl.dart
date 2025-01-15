import 'package:dartz/dartz.dart';
import '/domain/analisi_immagini/repositories/analisi_immagini_repository.dart';
import '/data/analisi_immagini/sources/analisi_immagini.dart';

class AnalisiImmaginiRepositoryImpl implements AnalisiImmaginiRepository {
  final OpenAIService _openAIService;

  AnalisiImmaginiRepositoryImpl(this._openAIService);

  @override
  Future<Either<String, Map<String, dynamic>>> analyzeImage(
      List<String> imagePaths) {
    return _openAIService.analyzeImageWithGPT(imagePaths);
  }
}
