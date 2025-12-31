import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              onPressed: () {
                // Логику выхода добавим позже
                Navigator.of(context).pop(); 
              },
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}