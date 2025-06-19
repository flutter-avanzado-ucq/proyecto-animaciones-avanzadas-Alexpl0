// main.dart
//https://github.com/flutter-avanzado-ucq/proyecto-animaciones-avanzadas-Alexpl0
import 'package:flutter/material.dart';
import 'screens/tarea_screen.dart';
import 'tema/tema_app.dart'; // # 18 de Junio; se agregó importación de tema personalizado
import 'package:provider/provider.dart';
import 'provider_task/task_provider.dart';

import 'services/notification_service.dart'; // # 18 de Junio; se agregó servicio de notificaciones


void main() async { // # 18 de Junio; se agregó async para inicialización de servicios
  WidgetsFlutterBinding.ensureInitialized(); // # 18 de Junio; se agregó inicialización de Flutter

  // # 18 de Junio; se agregó inicialización de notificaciones
  await NotificationService.initializeNotifications();

  // # 18 de Junio; se agregó solicitud de permisos para notificaciones
  await NotificationService.requestPermission();

  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // # 18 de Junio; se removió el segundo ChangeNotifierProvider duplicado
      debugShowCheckedModeBanner: false,
      title: 'Tareas Pro',
      theme: AppTheme.theme, // # 18 de Junio; se cambió de ThemeData(primarySwatch: Colors.deepPurple) a AppTheme.theme
      home: const TaskScreen(),
    );
  }
}
