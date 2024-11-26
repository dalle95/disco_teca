import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/core/usecase/usecase.dart';
import '/domain/disco/repositories/disco.dart';

class GetDischiUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<DischiRepository>().getDischi(params);
  }
}
