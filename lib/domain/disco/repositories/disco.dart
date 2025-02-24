import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/disco/entities/disco.dart';

abstract class DischiRepository {
  // Per gestire i log
  final logger = sl<Logger>();

  Future<Either> getDischi(String? ordine);
  Future<Either> getDischiPerPosizione(String? posizione);
  Future<Either> getRicercaDischi(String parametro);

  Stream<Either<String, List<DiscoEntity>>> watchDischi({
    bool withImages,
    String? ordine,
  });
  Stream<Either<String, List<DiscoEntity>>> watchDischiPerPosizione(
      String? posizione);

  Future<Either> salvaDisco(DiscoEntity disco);
  Future<Either> eliminaDisco(DiscoEntity disco);
}
