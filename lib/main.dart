import 'package:flutter/material.dart';
// import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/splash_screen.dart';

void main() {
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Убираем ленточку DEBUG
      title: 'Auth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Используем современный стиль Material 3
      ),
      home: const SplashScreen(),
    );
  }
}