import 'package:dartz/dartz.dart';
import '/data/auth/models/signin_req_params.dart';

import '../../../data/auth/models/register_req_params.dart';

abstract class AuthRepository {
  Future<Either> register(RegisterReqParams params);
  Future<Either> signin(SigninReqParams params);
  Future<bool> isLoggedIn();
  Future<Either> logout();
}
