import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/data/auth/models/register_req_params.dart';
import '/data/auth/models/signin_req_params.dart';
import '/data/auth/sources/auth_api_service.dart';
import '/domain/auth/repositories/auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FlutterSecureStorage _storage = sl<FlutterSecureStorage>();

  @override
  Future<Either<String, UserCredential>> register(
      RegisterReqParams params) async {
    var data = await sl<AuthService>().register(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (userCredential) async {
        // Ottiene il token dell'utente
        String? token = await userCredential.user?.getIdToken();
        if (token != null) {
          await _storage.write(key: 'token', value: token);
        }
        return Right(userCredential);
      },
    );
  }

  @override
  Future<Either<String, UserCredential>> signin(SigninReqParams params) async {
    var data = await sl<AuthService>().signin(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (userCredential) async {
        // Ottiene il token dell'utente
        String? token = await userCredential.user?.getIdToken();
        if (token != null) {
          await _storage.write(key: 'token', value: token);
        }
        return Right(userCredential);
      },
    );
  }

  Future<Either<String, UserCredential>> signinWithGoogle() async {
    var data = await sl<AuthService>().signinWithGoogle();
    return data.fold(
      (error) {
        return Left(error);
      },
      (userCredential) async {
        // Ottiene il token dell'utente
        String? token = await userCredential.user?.getIdToken();
        if (token != null) {
          await _storage.write(key: 'token', value: token);
        }
        return Right(userCredential);
      },
    );
  }

  @override
  Future<Either<String, UserCredential>> registerWithGoogle() async {
    var data = await sl<AuthService>().registerWithGoogle();
    return data.fold(
      (error) {
        return Left(error);
      },
      (userCredential) async {
        // Ottiene il token dell'utente
        String? token = await userCredential.user?.getIdToken();
        if (token != null) {
          await _storage.write(key: 'token', value: token);
        }
        return Right(userCredential);
      },
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    String? token = await _storage.read(key: 'token');
    return token != null;
  }

  @override
  Future<Either<String, void>> logout() async {
    var data = await sl<AuthService>().logout();
    return data.fold(
      (error) {
        return Left(error);
      },
      (_) async {
        Logger().d('Logout');
        await _storage.delete(key: 'token');
        return const Right(null);
      },
    );
  }
}
