import 'package:dartz/dartz.dart';

import '/service_locator.dart';
import '/core/usecase/usecase.dart';
import '/domain/foto_disco/repositories/foto_disco.dart';

class LoadImagesUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<FotoDiscoRepository>().loadImages(params!);
  }
}
