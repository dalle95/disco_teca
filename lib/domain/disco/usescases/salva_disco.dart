import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/usecase/usecase.dart';
import '/domain/disco/repositories/disco.dart';
import '/domain/disco/entities/disco.dart';

class SalvaDiscoUseCase extends UseCase<Either, DiscoEntity> {
  @override
  Future<Either> call({DiscoEntity? params}) async {
    return await sl<DischiRepository>().salvaDisco(params!);
  }
}
