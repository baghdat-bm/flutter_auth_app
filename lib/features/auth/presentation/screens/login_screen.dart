import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Отступы от краев экрана
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ), // Ограничим ширину для Desktop
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Центрируем по вертикали
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Растягиваем элементы по ширине
              children: [
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16), // Пустое пространство между полями
                const TextField(
                  obscureText: true, // Скрываем ввод пароля
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Пока просто выведем в консоль
                    print('Нажата кнопка Войти');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Войти'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Переход на экран регистрации
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
