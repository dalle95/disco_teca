import 'package:dartz/dartz.dart';
import '/core/usecase/usecase.dart';
import '/domain/auth/repositories/auth.dart';
import '/service_locator.dart';

class SigninWithGoogleUseCase extends UseCase<Either, void> {
  @override
  Future<Either> call({void params}) async {
    return await sl<AuthRepository>().signinWithGoogle();
  }
}
