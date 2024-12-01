import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/common/helper/errors/firebase_gestione_errori.dart';

abstract class DownloadAppService {
  // Logger per debug
  final logger = sl<Logger>();

  // Metodo astratto per controllare se è presente un'altra versione dell'app
  Future<Either<String, bool>> getNuovaVersioneApp();

  // Metodo astratto per il download
  Future<Either<String, String>> downloadAppFile({
    required void Function(double progress) onProgress,
  });
}

class DownloadAppApiServiceImpl extends DownloadAppService {
  final FirebaseRemoteConfig _firebaseRemoteConfig = sl<FirebaseRemoteConfig>();
  final Dio _dio = sl<Dio>();

  @override
  Future<Either<String, String>> downloadAppFile({
    required void Function(double progress) onProgress,
  }) async {
    logger.d("DownloadAppApiServiceImpl | Funzione: downloadAppFile");

    // Sincronizza i dati da Remote Config
    await _firebaseRemoteConfig.fetchAndActivate();

    // Recupera l'URL del file e la versione dal Remote Config
    final downloadUrl = _firebaseRemoteConfig.getString('downloadUrl');
    final lastAppVersion = _firebaseRemoteConfig.getString('lastAppVersion');
    final String url =
        '$downloadUrl/${lastAppVersion.replaceAll('+', '/')}/app-release.apk';

    logger.d('URL: $url');

    // Recupera il percorso del file di destinazione
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/newVersionApp.apk';

    try {
      await _dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            onProgress(progress); // Notifica il progresso
          }
        },
      );

      logger.d(
        "DownloadAppApiServiceImpl | Download completato | Percorso: $filePath",
      );
      return Right(filePath);
    } on FirebaseException catch (e) {
      logger.e("DownloadAppApiServiceImpl | Errore Firebase: ${e.message}");
      return Left(FirebaseGestioneErrori.descrizioneErrore(e));
    } on DioException catch (e) {
      logger.e("DownloadAppApiServiceImpl | Errore Dio: ${e.message}");
      return Left("Errore durante il download: ${e.message}");
    } catch (e) {
      logger.e("DownloadAppApiServiceImpl | Errore generico: $e");
      return Left("Errore sconosciuto durante il download");
    }
  }

  @override
  Future<Either<String, bool>> getNuovaVersioneApp() async {
    logger.d("DownloadAppApiServiceImpl | Funzione: getNuovaVersioneApp");

    try {
      // Sincronizza i dati da Remote Config
      await _firebaseRemoteConfig.fetchAndActivate();

      // Recupera l'URL del file e la versione dal Remote Config
      final infoVersioneFirebase =
          (_firebaseRemoteConfig.getString('lastAppVersion'))
              .replaceAll('+', '.');

      // Recupero la versione dell'applicazione
      final infoApp = await PackageInfo.fromPlatform();
      final infoVersioneApp = '${infoApp.version}.${infoApp.buildNumber}';

      logger.d(
        "Nuova versione app presente: $infoVersioneFirebase (Attuale $infoVersioneApp)",
      );

      // Confronto Versioni in formato stringa
      if (infoVersioneFirebase != infoVersioneApp) {
        return Right(true);
      } else {
        return Right(false);
      }
    } on FirebaseException catch (e) {
      logger.e("DownloadAppApiServiceImpl | Errore Firebase: ${e.message}");
      return Left(FirebaseGestioneErrori.descrizioneErrore(e));
    } catch (e) {
      logger.e("DownloadAppApiServiceImpl | Errore generico: $e");
      return Left("Errore sconosciuto durante l'estrazione nuova versione");
    }
  }
}
