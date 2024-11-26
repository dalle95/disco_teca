import 'package:dartz/dartz.dart';
import '/core/usecase/usecase.dart';
import '/data/auth/models/signin_req_params.dart';
import '/domain/auth/repositories/auth.dart';
import '/service_locator.dart';

class SigninUseCase extends UseCase<Either, SigninReqParams> {
  @override
  Future<Either> call({SigninReqParams? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}
