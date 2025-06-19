import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// 18 de Junio; se agregó servicio de notificaciones para recordatorios de tareas
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // # 18 de Junio; se corrigió inicialización usando tu ícono personalizado
  static Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    const androidSettings = AndroidInitializationSettings('ic_notification'); // # 18 de Junio; se corrigió para usar tu ícono personalizado sin @ ni extensión
    const iosSettings = DarwinInitializationSettings();
    
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
  }

  // 18 de Junio; se agregó handler para respuesta de notificaciones
  static void _onNotificationResponse(NotificationResponse response) {
    if (response.payload != null) {
      // # 18 de Junio; se mejoró el manejo de respuesta de notificaciones
      print('Notificación recibida - Payload: ${response.payload}');
    }
  }

  // # 18 de Junio; se mejoró solicitud de permisos con mejor manejo de errores
  static Future<bool> requestPermission() async {
    try {
      if (await Permission.notification.isDenied ||
          await Permission.notification.isPermanentlyDenied) {
        final status = await Permission.notification.request();
        if (status.isDenied) return false;
      }

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      
      return true;
    } catch (e) {
      print('Error solicitando permisos de notificación: $e');
      return false;
    }
  }

  // # 18 de Junio; se agregó método showImmediateNotification como alias de showNotification
  static Future<void> showImmediateNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await showNotification(title: title, body: body, payload: payload);
  }

  // # 18 de Junio; se mejoró método con mejor manejo de errores y tu ícono personalizado
  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'instant_channel',
        'Notificaciones Instantáneas',
        channelDescription: 'Canal para notificaciones inmediatas',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: false, 
        icon: 'ic_notification', // # 18 de Junio; se especificó tu ícono personalizado
      );

      const details = NotificationDetails(android: androidDetails);

      await _notificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000), // Notification ID
        title,
        body,
        details,
        payload: payload,
      );
      
      print('Notificación mostrada: $title'); // # 18 de Junio; se agregó log para debugging
    } catch (e) {
      print('Error mostrando notificación: $e');
    }
  }

  // # 18 de Junio; se mejoró programación de notificaciones con tu ícono personalizado
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    try {
      // # 18 de Junio; se agregó validación de fecha futura
      if (scheduledDate.isBefore(DateTime.now())) {
        print('No se puede programar notificación para fecha pasada');
        return;
      }

      const androidDetails = AndroidNotificationDetails(
        'scheduled_channel',
        'Notificaciones Programadas',
        channelDescription: 'Canal para recordatorios de tareas',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true, 
        icon: 'ic_notification', // # 18 de Junio; se especificó tu ícono personalizado
      );

      const details = NotificationDetails(android: androidDetails);

      await _notificationsPlugin.zonedSchedule(
        DateTime.now().millisecondsSinceEpoch.remainder(100000), // Notification ID
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload,
      );
      
      print('Notificación programada para: $scheduledDate'); // # 18 de Junio; se agregó log para debugging
    } catch (e) {
      print('Error programando notificación: $e');
    }
  }
}