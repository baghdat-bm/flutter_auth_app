import 'package:dio/dio.dart';
import '../models/auth_token_model.dart';

class AuthRemoteDataSource {
  // 1. Теперь мы просто храним переменную, но не создаем её здесь
  final Dio dio;

  // 2. Добавляем конструктор, который ТРЕБУЕТ передать dio
  AuthRemoteDataSource({required this.dio});

  // Метод для входа (MOCK)
  Future<AuthTokenModel> login(String email, String password) async {
    print('1. Метод login вызван (Режим симуляции через DI)');

    await Future.delayed(const Duration(milliseconds: 1500));

    if (password.length < 4) {
      throw Exception('Пароль слишком короткий!');
    }

    print('2. Возвращаем фейковый токен');
    final fakeJson = {'token': 'QpwL5tke4Pnpja7X4'};
    
    return AuthTokenModel.fromJson(fakeJson);
  }

  // Если бы мы использовали реальный запрос, код был бы таким:
  /*
  Future<AuthTokenModel> loginReal(String email, String password) async {
    try {
      // Обращаемся к this.dio (который нам передали)
      final response = await dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );
      return AuthTokenModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  */
}