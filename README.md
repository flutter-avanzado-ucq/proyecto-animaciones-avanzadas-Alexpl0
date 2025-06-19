# Aplicación de Tareas con Animaciones Avanzadas

Este proyecto implementa una aplicación de gestión de tareas con animaciones avanzadas para mejorar la experiencia del usuario.


## Cambios Implementados - 19 de diciembre

### 1. Sistema de Notificaciones Completo
- **Nuevo NotificationService**: Servicio completo para manejo de notificaciones locales.
- **Notificaciones inmediatas**: Al crear y editar tareas.
- **Notificaciones programadas**: Para fechas de vencimiento de tareas.
- **Manejo automático de permisos**: Solicitud y verificación de permisos de notificación.
- **Soporte para timezone**: Programación exacta de notificaciones.
- **Ícono personalizado**: Integración de `ic_notification` para las notificaciones.

### 2. Tema Personalizado de la Aplicación
- **AppTheme**: Implementación de tema personalizado con Material 3.
- **Google Fonts**: Integración de fuente Poppins para toda la aplicación.
- **Esquema de colores**: Paleta de colores unificada basada en azul.
- **Estilos consistentes**: Botones, AppBar y scaffold con diseño coherente.

### 3. Integración de Notificaciones en Widgets
- **AddTaskSheet**: Notificaciones al crear nuevas tareas.
- **EditTaskSheet**: Notificaciones al actualizar tareas existentes.
- **Notificaciones contextuales**: Mensajes específicos según la acción realizada.

### 4. Inicialización Mejorada
- **Main.dart async**: Inicialización asíncrona del servicio de notificaciones.
- **Permisos al inicio**: Solicitud automática de permisos al arrancar la app.
- **Configuración centralizada**: Integración del tema personalizado desde el inicio.

### 5. Mejoras en la Experiencia de Usuario
- **Feedback inmediato**: Notificaciones que confirman acciones del usuario.
- **Recordatorios programados**: Sistema de alertas para fechas importantes.
- **Diseño cohesivo**: Interfaz unificada con el nuevo sistema de temas y notificaciones.