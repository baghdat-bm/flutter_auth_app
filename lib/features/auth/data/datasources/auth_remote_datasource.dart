import 'package:dio/dio.dart';
import '../models/auth_token_model.dart';

class AuthRemoteDataSource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 👇 Добавляем нашу "маскировку" под Chrome:
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      },
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  // Метод для входа (MOCK / ЗАГЛУШКА)
  Future<AuthTokenModel> login(String email, String password) async {
    print('1. Метод login вызван (Режим симуляции)');

    // 1. Имитируем ожидание сети (задержка 1.5 секунды)
    // Это нужно, чтобы увидеть индикатор загрузки на экране в будущем
    await Future.delayed(const Duration(milliseconds: 1500));

    // 2. Имитируем проверку пароля (для теста)
    if (password.length < 4) {
      // Выбрасываем ошибку, если пароль слишком короткий
      throw Exception('Пароль слишком короткий!');
    }

    // 3. Возвращаем успешный результат, как будто сервер ответил JSON
    print('2. Возвращаем фейковый токен');
    final fakeJson = {'token': 'QpwL5tke4Pnpja7X4'};

    return AuthTokenModel.fromJson(fakeJson);
  }

  // Метод для регистрации
  Future<AuthTokenModel> register(String email, String password) async {
    try {
      final response = await _dio.post(
        '/register',
        data: {'email': email, 'password': password},
      );
      return AuthTokenModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Ошибка регистрации');
    }
  }
}
