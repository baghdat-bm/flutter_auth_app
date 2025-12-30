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
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      },
      validateStatus: (status) {
        return status != null && status < 500; 
      },
    ),
  );

  // Метод для входа
  Future<AuthTokenModel> login(String email, String password) async {
    print('1. Метод login вызван'); // Проверка старта

    try {
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      print('2. Ответ получен: ${response.data}');
      print('3. Тип данных ответа: ${response.data.runtimeType}');

      return AuthTokenModel.fromJson(response.data);
    } catch (e, stackTrace) {
      // Ловим АБСОЛЮТНО ВСЕ ошибки
      print('!!! ПРОИЗОШЛА ОШИБКА !!!');
      print('Текст ошибки: $e');
      print('Где именно (Stack Trace): $stackTrace');

      // Пробрасываем ошибку дальше, чтобы UI тоже о ней узнал
      throw Exception('Ошибка в сервисе: $e');
    }
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
