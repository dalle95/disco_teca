import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

abstract class DownloadAppRepository {
  // Per gestire i log
  final logger = sl<Logger>();

  Future<Either<String, bool>> getPresenzaNuovaVersione();

  Future<Either<String, String>> getDownload(
      {required void Function(double progress) onProgress});
}
