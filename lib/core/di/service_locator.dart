import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // 1. Регистрируем Dio с настройками (BaseOptions)
  // Мы перенесли настройки сюда, чтобы они были в одном месте
  sl.registerLazySingleton<Dio>(() => Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      },
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  ));

  // 2. Регистрируем Secure Storage
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // 3. Регистрируем наш сервис
  // Теперь ошибки не будет, так как мы добавили именованный параметр {required this.dio} в классе выше
  sl.registerLazySingleton(() => AuthRemoteDataSource(dio: sl())); 
}