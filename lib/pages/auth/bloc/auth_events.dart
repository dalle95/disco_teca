abstract class AuthEvent {
  const AuthEvent();
}

class LoadingEvent extends AuthEvent {
  LoadingEvent();
}

class VistaEvent extends AuthEvent {
  const VistaEvent();
}

class UsernameEvent extends AuthEvent {
  final String? username;
  const UsernameEvent(this.username);
}

class PasswordEvent extends AuthEvent {
  final String? password;
  const PasswordEvent(this.password);
}

class Password2Event extends AuthEvent {
  final String password2;
  const Password2Event(this.password2);
}
