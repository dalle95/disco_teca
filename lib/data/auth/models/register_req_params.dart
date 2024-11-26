// ignore_for_file: public_member_api_docs, sort_constructors_first

class RegisterReqParams {
  final String email;
  final String password;
  final String passwordRipetuta;
  RegisterReqParams({
    required this.email,
    required this.password,
    required this.passwordRipetuta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'passwordRipetuta': passwordRipetuta,
    };
  }
}
