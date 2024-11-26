import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/common/helper/errors/firebase_gestione_errori.dart';

import '/data/auth/models/register_req_params.dart';
import '/data/auth/models/signin_req_params.dart';

abstract class AuthService {
  // Per gestire i log
  final logger = sl<Logger>();

  Future<Either<String, UserCredential>> register(RegisterReqParams params);
  Future<Either<String, UserCredential>> signin(SigninReqParams params);
  Future<Either<String, void>> logout();
}

class AuthApiServiceImpl extends AuthService {
  final FirebaseAuth _firebaseAuth = sl<FirebaseAuth>();

  @override
  Future<Either<String, UserCredential>> register(
    RegisterReqParams params,
  ) async {
    logger.d("AuthApiServiceImpl | Funzione: register");
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      logger
          .d('AuthApiServiceImpl | Funzione: register | Errore: ${e.message}');
      return Left(FirebaseGestioneErrori.descrizioneErroreAuth(e));
    }
  }

  @override
  Future<Either<String, UserCredential>> signin(SigninReqParams params) async {
    logger.d("AuthApiServiceImpl | Funzione: signin");

    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      logger.d('AuthApiServiceImpl | Funzione: signin | Errore: ${e.message}');
      return Left(FirebaseGestioneErrori.descrizioneErroreAuth(e));
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    logger.d("AuthApiServiceImpl | Funzione: logout");

    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      logger.d('AuthApiServiceImpl | Funzione: logout | Errore: ${e.message}');
      return Left(FirebaseGestioneErrori.descrizioneErroreAuth(e));
    }
  }
}
