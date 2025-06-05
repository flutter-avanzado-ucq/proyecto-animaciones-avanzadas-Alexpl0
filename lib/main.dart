// main.dart
//https://github.com/flutter-avanzado-ucq/proyecto-animaciones-avanzadas-Alexpl0
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider_task/task_provider.dart';
import 'screens/tarea_screen.dart';
import 'tema/tema_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tareas Pro',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const TaskScreen(),
      ),
    );
  }
}
