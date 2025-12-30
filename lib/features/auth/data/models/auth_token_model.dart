class AuthTokenModel {
  final String token;

  AuthTokenModel({required this.token});

  // Фабрика для создания объекта из JSON (который приходит от сервера)
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      token: json['token'] as String,
    );
  }
}