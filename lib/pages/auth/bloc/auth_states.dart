class AuthState {
  const AuthState({
    this.username,
    this.password,
    this.password2,
    this.vista = 'Login',
  });

  final String? username;
  final String? password;
  final String? password2;
  final String vista;

  AuthState copyWith({
    String? username,
    String? password,
    String? password2,
    String? vista,
  }) {
    return AuthState(
      username: username ?? this.username,
      password: password ?? this.password,
      password2: password2 ?? this.password2,
      vista: vista ?? this.vista,
    );
  }
}
