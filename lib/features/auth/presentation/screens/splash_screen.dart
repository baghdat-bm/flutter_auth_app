import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'login_screen.dart';
import '../../../home/home_screen.dart'; // Убедись, что путь правильный

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Инициализируем хранилище
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  // Метод проверки авторизации
  Future<void> _checkAuth() async {
    // 1. (Опционально) Добавляем небольшую задержку, чтобы пользователь успел увидеть логотип
    // Иначе, если телефон быстрый, экран просто "моргнет"
    await Future.delayed(const Duration(seconds: 2));

    // 2. Читаем токен из памяти
    final token = await _storage.read(key: 'auth_token');

    // Проверяем, смонтирован ли виджет (не ушел ли пользователь с экрана)
    if (!mounted) return;

    // 3. Решаем, куда отправить пользователя
    if (token != null) {
      // Токен есть -> идем на Главную
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Токена нет -> идем на Логин
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue, // Сделаем фон цветным для красоты
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Иконка или логотип
            Icon(Icons.flutter_dash, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Auth App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Индикатор загрузки
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}