import 'package:dartz/dartz.dart';

import '/service_locator.dart';

import '/common/helper/mapper/dischi.dart';

import '/data/disco/sources/disco.dart';
import '/domain/disco/repositories/disco.dart';
import '/domain/disco/entities/disco.dart';

class DischiRepositoryImpl extends DischiRepository {
  @override
  Future<Either> getDischi(String? ordine) async {
    logger.d("DischiRepositoryImpl | Funzione: getDischi");

    switch (ordine) {
      case null:
      case 'Artista':
        ordine = 'autore';
        break;
      case 'Titolo':
        ordine = 'titoloAlbum';
        break;
      default:
        ordine = ordine.toLowerCase();
        break;
    }

    logger.d('Ordine: $ordine');

    var data = await sl<DischiService>().getDischi(ordine);

    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        var dischi =
            List.from(data).map((item) => DischiMapper.toEntity(item)).toList();
        return Right(dischi);
      },
    );
  }

  @override
  Future<Either> getRicercaDischi(String parametro) async {
    logger.d("DischiRepositoryImpl | Funzione: getRicercaDischi");
    logger.d('Ricerca: $parametro');

    var data = await sl<DischiService>().getRicercaDischi(parametro);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        var dischi =
            List.from(data).map((item) => DischiMapper.toEntity(item)).toList();
        return Right(dischi);
      },
    );
  }

  @override
  Stream<Either<String, List<DiscoEntity>>> watchDischi({
    bool? withImages,
    String? ordine,
  }) {
    logger.d("DischiRepositoryImpl | Function: watchDischi($ordine)");

    // Convert from Service (DiscoModel) to Entity (DiscoEntity)
    return sl<DischiService>()
        .watchDischi(ordine: ordine, withImages: withImages)
        .map<Either<String, List<DiscoEntity>>>((either) {
      if (either.isLeft()) {
        // Pass the error along
        return Left(either.swap().getOrElse(() => 'Unknown error'));
      } else {
        // Convert the Right<List<DiscoModel>> -> Right<List<DiscoEntity>>
        final models = either.getOrElse(() => []);
        final List<DiscoEntity> entities =
            models.map((model) => DischiMapper.toEntity(model)).toList();
        return Right(entities);
      }
    });
  }

  @override
  Stream<Either<String, List<DiscoEntity>>> watchDischiPerPosizione(
      String? posizione) {
    logger.d(
        "DischiRepositoryImpl | Function: watchDischiPerPosizione($posizione)");

    return sl<DischiService>()
        .watchDischiPerPosizione(posizione)
        .map<Either<String, List<DiscoEntity>>>((either) {
      if (either.isLeft()) {
        return Left(either.swap().getOrElse(() => 'Unknown error'));
      } else {
        final models = either.getOrElse(() => []);
        final List<DiscoEntity> entities =
            models.map((model) => DischiMapper.toEntity(model)).toList();
        return Right(entities);
      }
    });
  }

  @override
  Future<Either> salvaDisco(DiscoEntity disco) async {
    logger.d("DischiRepositoryImpl | Funzione: salvaDisco");

    var data = await sl<DischiService>().salvaDisco(disco);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> eliminaDisco(DiscoEntity disco) async {
    logger.d("DischiRepositoryImpl | Funzione: eliminaDisco");

    var data = await sl<DischiService>().eliminaDisco(disco);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> getDischiPerPosizione(String? posizione) async {
    logger.d("DischiRepositoryImpl | Funzione: getDischiPerPosizione");
    logger.d('Ricerca: $posizione');

    var data = await sl<DischiService>().getDischiPerPosizione(posizione);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        var dischi =
            List.from(data).map((item) => DischiMapper.toEntity(item)).toList();
        return Right(dischi);
      },
    );
  }
}
