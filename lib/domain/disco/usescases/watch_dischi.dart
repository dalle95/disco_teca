import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/usecase/usecase.dart';
import '/domain/disco/repositories/disco.dart';
import '/domain/disco/entities/disco.dart';

class WatchDischiParamters {
  final String? ordine;
  final bool withImages;

  WatchDischiParamters({
    this.ordine,
    this.withImages = true,
  });
}

class WatchDischiUseCase extends StreamUseCase<
    Either<String, List<DiscoEntity>>, WatchDischiParamters> {
  @override
  Stream<Either<String, List<DiscoEntity>>> call(
      {WatchDischiParamters? params}) {
    return sl<DischiRepository>().watchDischi(
      ordine: params?.ordine,
      withImages: params == null ? false : params.withImages,
    );
  }
}
