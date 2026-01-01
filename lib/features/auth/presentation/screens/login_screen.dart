import 'package:flutter/material.dart';
import '../../data/datasources/auth_remote_datasource.dart'; // Импорт нашего сервиса
import 'register_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../home/home_screen.dart'; // Путь к новому экрану
import '../../../../core/di/service_locator.dart'; // Импортируем sl

// Меняем на StatefulWidget, чтобы хранить состояние (текст в полях)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Создаем контроллеры для полей ввода
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Берем готовый экземпляр из DI
  final _authService = sl<AuthRemoteDataSource>();

  final _storage = const FlutterSecureStorage();

  bool _isLoading = false;

  // Функция для обработки нажатия кнопки "Войти"
  Future<void> _login() async {
    // Простая валидация: если поля пустые, не отправляем запрос
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Заполните email и пароль')));
      return;
    }

    // Включаем загрузку и обновляем экран
    setState(() {
      _isLoading = true;
    });

    try {
      final tokenModel = await _authService.login(
        _emailController.text,
        _passwordController.text,
      );

      // 1. Сохраняем токен в безопасное хранилище
      await _storage.write(key: 'auth_token', value: tokenModel.token);

      if (mounted) {
        // 2. Переходим на главный экран
        // pushReplacement означает "заменить текущий экран", чтобы нельзя было вернуться назад кнопкой "Back"
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      // В любом случае (успех или ошибка) выключаем загрузку
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Не забываем освобождать ресурсы контроллеров
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _emailController, // 3. Привязываем контроллер
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController, // 3. Привязываем контроллер
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                // Если идет загрузка - показываем спиннер, иначе кнопку
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Войти'),
                        ),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('Нет аккаунта? Зарегистрироваться'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
