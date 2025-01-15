import 'package:dartz/dartz.dart';

abstract class AnalisiImmaginiRepository {
  Future<Either<String, Map<String, dynamic>>> analyzeImage(
    List<String> imagePaths,
  );
}
