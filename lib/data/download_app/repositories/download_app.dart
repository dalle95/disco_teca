import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/data/download_app/sources/download_app.dart';

import '/domain/download_app/repositories/download_app.dart';

class DownloadAppRepositoryImpl extends DownloadAppRepository {
  @override
  Future<Either<String, String>> getDownload(
      {required void Function(double progress) onProgress}) async {
    final result =
        await sl<DownloadAppService>().downloadAppFile(onProgress: onProgress);

    return result.fold(
      (error) => Left(error),
      (filePath) => Right(filePath),
    );
  }

  @override
  Future<Either<String, bool>> getPresenzaNuovaVersione() async {
    final result = await sl<DownloadAppService>().getNuovaVersioneApp();

    return result.fold(
      (error) => Left(error),
      (nuovaVersione) => Right(nuovaVersione),
    );
  }
}
