# Aplicación de Tareas con Animaciones Avanzadas

Este proyecto implementa una aplicación de gestión de tareas con animaciones avanzadas para mejorar la experiencia del usuario.

## Cambios Implementados - 04 de junio

### 1. Implementación de funcionalidad de edición de tareas
- Creación del widget EditTaskSheet para permitir la edición de tareas existentes.
- Agregación de la propiedad index en TaskCard para identificar cada tarea específica.
- Implementación de showModalBottomSheet para mostrar el formulario de edición.
- Integración del botón de editar en la interfaz de cada tarea.

### 2. Actualización del TaskProvider
- Agregación de la función updateTask() para modificar tareas existentes.
- Implementación de la lógica para actualizar tanto el título como la fecha de las tareas.
- Mantenimiento de la notificación de cambios con notifyListeners().

### 3. Mejoras en la interfaz de usuario
- Modificación del trailing en TaskCard de un solo botón a Row con dos botones (editar y eliminar).
- Agregación del botón de editar con ícono específico y color diferenciado.
- Mantenimiento del botón de eliminar existente junto al nuevo botón de editar.
- Mejora en la experiencia de usuario permitiendo la edición completa de tareas.