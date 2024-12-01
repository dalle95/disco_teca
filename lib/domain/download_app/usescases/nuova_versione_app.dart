import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/usecase/usecase.dart';

import '/domain/download_app/repositories/download_app.dart';

class GetNuovaVersioneAppUseCase extends UseCase<Either, bool> {
  @override
  Future<Either<String, bool>> call({bool? params}) async {
    return await sl<DownloadAppRepository>().getPresenzaNuovaVersione();
  }
}
