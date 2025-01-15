import 'package:dartz/dartz.dart';
import '/domain/analisi_immagini/repositories/analisi_immagini_repository.dart';

class AnalyzeImageUseCase {
  final AnalisiImmaginiRepository repository;

  AnalyzeImageUseCase(this.repository);

  Future<Either<String, Map<String, dynamic>>> call(List<String> imagePaths) {
    return repository.analyzeImage(imagePaths);
  }
}
