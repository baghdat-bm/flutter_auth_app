import 'package:auth_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Функция выхода
  Future<void> _logout(BuildContext context) async {
    // 1. Инициализируем хранилище
    const storage = FlutterSecureStorage();

    // 2. Удаляем токен
    await storage.delete(key: 'auth_token');
    // Или можно использовать storage.deleteAll(), если нужно стереть вообще всё

    if (context.mounted) {
      // 3. Переходим на экран входа и удаляем всю историю переходов
      // (predicate: (route) => false означает "удалить все предыдущие маршруты")
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Добро пожаловать!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Сделаем кнопку красной
                foregroundColor: Colors.white,
              ),
              onPressed: () => _logout(context), // Вызываем нашу функцию
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}