import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/usecase/usecase.dart';

import '/domain/download_app/repositories/download_app.dart';

class DownloadAppUseCase
    extends UseCase<Either<String, String>, void Function(double progress)> {
  @override
  Future<Either<String, String>> call(
      {void Function(double progress)? params}) async {
    return await sl<DownloadAppRepository>().getDownload(onProgress: params!);
  }
}
