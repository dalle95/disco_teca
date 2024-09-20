import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<VistaEvent>(_vistaEvent);
    on<UsernameEvent>(_usernameEvent);
    on<PasswordEvent>(_passwordEvent);
    on<Password2Event>(_password2Event);
  }

  void _vistaEvent(VistaEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        vista: state.vista == 'Login' ? 'Registrazione' : 'Login',
      ),
    );
  }

  void _usernameEvent(UsernameEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _passwordEvent(PasswordEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _password2Event(Password2Event event, Emitter<AuthState> emit) {
    emit(state.copyWith(password2: event.password2));
  }
}
