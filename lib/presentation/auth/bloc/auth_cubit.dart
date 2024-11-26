import 'package:app_disco_teca/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/data/auth/models/register_req_params.dart';
import '/data/auth/models/signin_req_params.dart';
import '/domain/auth/usecases/register.dart';
import '/domain/auth/usecases/signin.dart';
import '/presentation/auth/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SigninUseCase _signinUseCase;
  final RegisterUseCase _registerUseCase;

  AuthCubit(this._signinUseCase, this._registerUseCase) : super(AuthState());

  // Per gestire i log
  final logger = sl<Logger>();

  Future<void> signIn(
    String email,
    String password,
  ) async {
    logger.d('AuthCubit | Funzione: signIn');

    emit(
      state.copyWith(isLoading: true, errorMessage: null, isSuccess: false),
    );

    if (email.isEmpty || password.isEmpty) {
      logger.d('Errore validazione dati');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Email e password devono essere compilate',
        ),
      );
      return;
    }

    final result = await _signinUseCase.call(
      params: SigninReqParams(
        email: email,
        password: password,
      ),
    );
    result.fold(
      (error) {
        logger.d('Errore durante il login');
        emit(
          state.copyWith(isLoading: false, errorMessage: error),
        );
      },
      (_) {
        logger.d('Login avvenuta con successo');
        emit(
          state.copyWith(isLoading: false, isSuccess: true),
        );
      },
    );
  }

  Future<void> register(
    String email,
    String password,
    String passwordRipetuta,
  ) async {
    logger.d('AuthCubit | Funzione: register');

    emit(
      state.copyWith(isLoading: true, errorMessage: null, isSuccess: false),
    );

    if (email.isEmpty || password.isEmpty || passwordRipetuta.isEmpty) {
      logger.d('Errore validazione dati');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Email e password devono essere compilate',
        ),
      );
      return;
    }
    if (password != passwordRipetuta) {
      logger.d('Errore validazione password');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Le due password devono coincidere',
        ),
      );
      return;
    }
    final result = await _registerUseCase.call(
      params: RegisterReqParams(
        email: email,
        password: password,
        passwordRipetuta: passwordRipetuta,
      ),
    );
    result.fold(
      (error) {
        logger.d('Errore durante la registrazione');
        emit(
          state.copyWith(isLoading: false, errorMessage: error),
        );
      },
      (_) {
        logger.d('Registrazione avvenuta con successo');
        emit(
          state.copyWith(isLoading: false, isSuccess: true),
        );
      },
    );
  }
}
