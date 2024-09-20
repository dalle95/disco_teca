class User {
  final String? token;
  final String? username;
  final String? password;
  final String? refreshDate;

  const User({
    this.token,
    this.username,
    this.password,
    this.refreshDate,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'username': username,
        'password': password,
        'refreshDate': refreshDate,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        username: json["username"],
        password: json["password"],
        refreshDate: json["refreshDate"],
      );
}
