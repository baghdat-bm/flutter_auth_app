import 'package:flutter/material.dart';
import '../../data/datasources/auth_remote_datasource.dart'; // Импорт нашего сервиса
import 'register_screen.dart';

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

  // Создаем экземпляр нашего сервиса API
  final _authService = AuthRemoteDataSource();

  // Функция для обработки нажатия кнопки "Войти"
  Future<void> _login() async {
    // Простая валидация: если поля пустые, не отправляем запрос
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните email и пароль')),
      );
      return;
    }

    try {
      // 2. Вызываем метод API
      final tokenModel = await _authService.login(
        _emailController.text,
        _passwordController.text,
      );

      // Если все прошло успешно:
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Успешный вход! Токен: ${tokenModel.token}'),
            backgroundColor: Colors.green,
          ),
        );
        // Тут можно сохранить токен и перейти на главный экран
      }
    } catch (e) {
      // Если произошла ошибка:
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()), // Показываем текст ошибки
            backgroundColor: Colors.red,
          ),
        );
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
                ElevatedButton(
                  onPressed: _login, // 4. Вызываем нашу функцию
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Войти'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
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