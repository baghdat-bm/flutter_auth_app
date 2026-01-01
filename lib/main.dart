import 'package:auth_app/core/di/service_locator.dart';
import 'package:flutter/material.dart';
// import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/splash_screen.dart';

void main() {
  setupServiceLocator();
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth App',

      // 1. Настройка СВЕТЛОЙ темы
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Основной цвет
          brightness: Brightness.light,
        ),
      ),

      // 2. Настройка ТЕМНОЙ темы
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor:
              Colors.blue, // Можно выбрать другой, например, Colors.indigo
          brightness:
              Brightness.dark, // Главный флаг: генерировать темную палитру
        ),
      ),

      // 3. Режим (по умолчанию и так system, но можно указать явно)
      themeMode: ThemeMode.system,

      home: const SplashScreen(),
    );
  }
}
