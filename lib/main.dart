// main.dart
//https://github.com/flutter-avanzado-ucq/proyecto-animaciones-avanzadas-Alexpl0
import 'package:flutter/material.dart';
// 02 de Junio; se agregó import de provider
import 'package:provider/provider.dart';
// 02 de Junio; se agregó import del TaskProvider
import 'provider_task/task_provider.dart';
import 'screens/tarea_screen.dart';
import 'tema/tema_app.dart';

void main() {
  // 02 de Junio; se cambió runApp simple por ChangeNotifierProvider
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
    // 02 de Junio; se agregó ChangeNotifierProvider como widget padre
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tareas Pro',
        // 02 de Junio; se cambió AppTheme.theme por ThemeData con primarySwatch
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const TaskScreen(),
      ),
    );
  }
}
