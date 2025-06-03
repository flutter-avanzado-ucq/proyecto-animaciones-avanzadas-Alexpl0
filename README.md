# Aplicación de Tareas con Animaciones Avanzadas

Este proyecto implementa una aplicación de gestión de tareas con animaciones avanzadas para mejorar la experiencia del usuario.

## Cambios Implementados

### 1. Implementación del patrón Provider para manejo de estado
- Creación de la carpeta `lib/providers/` con TaskProvider para centralizar la lógica de tareas.
- Refactorización completa de HomeScreen para utilizar Consumer y context.watch().
- Separación de responsabilidades entre la presentación y la lógica de negocio.
- Integración de Provider en main.dart con ChangeNotifierProvider.

### 2. Funcionalidad de selección de fecha
- Integración de DatePicker nativo de Flutter para seleccionar fechas específicas en las tareas.
- Actualización del modelo Task para incluir el campo selectedDate de tipo DateTime.
- Modificación del formulario de creación de tareas para mostrar el selector de fecha.
- Visualización de la fecha seleccionada en cada tarea dentro de la lista.

### 3. Mejoras en la interfaz de usuario
- Actualización del AddTaskDialog para incluir la selección de fecha con botón dedicado.
- Mejora en la presentación visual de las tareas mostrando la fecha seleccionada.
- Refinamiento de la experiencia de usuario en el flujo de creación de tareas.