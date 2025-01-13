import 'package:dartz/dartz.dart';

import '/service_locator.dart';
import '/core/usecase/usecase.dart';
import '/domain/foto_disco/repositories/foto_disco.dart';

class DeleteImageUseCase extends UseCase<Either, DeleteImageParams> {
  @override
  Future<Either> call({DeleteImageParams? params}) async {
    return await sl<FotoDiscoRepository>()
        .deleteImage(params!.discoId, params.side, params.imageId);
  }
}

class DeleteImageParams {
  final String discoId;
  final String side;
  final String imageId;

  DeleteImageParams({
    required this.discoId,
    required this.side,
    required this.imageId,
  });
}
