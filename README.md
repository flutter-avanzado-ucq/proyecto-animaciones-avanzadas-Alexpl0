# Aplicación de Tareas con Animaciones Avanzadas

Este proyecto implementa una aplicación de gestión de tareas con animaciones avanzadas para mejorar la experiencia del usuario.

## Animaciones Implementadas

### 1. Cambio de color con AnimatedContainer
- Proporciona retroalimentación visual al cambiar el fondo a rojo cuando una tarea se marca como completada o pendiente.
- Utiliza la clase AnimatedContainer de Flutter para realizar una transición suave de colores.
- La animación se activa automáticamente cuando el estado de la tarea cambia.
- El cambio gradual de color ayuda al usuario a percibir inmediatamente el cambio de estado.

### 2. Cambio de opacidad con AnimatedOpacity
- Reduce la visibilidad de tareas completadas para mantener el enfoque en las pendientes, creando una clara jerarquía visual.
- Las tareas completadas disminuyen su opacidad hasta un 60%, manteniendo su visibilidad pero distinguiéndolas claramente.
- La implementación permite que los elementos se reintegren con opacidad completa si se marcan como pendientes nuevamente.

### 3. Rotación de ícono con Transform.rotate
- Anima una rotación de 180 grados al marcar una tarea, transformando el indicador y añadiendo un elemento interactivo satisfactorio.
- El movimiento se ejecuta mediante un Transform.rotate envolviendo el ícono de la tarea.
- La animación completa un ciclo en 400 milisegundos, proporcionando un equilibrio perfecto entre respuesta inmediata y percepción del movimiento.

### 4. AnimatedIcon en el FloatingActionButton
- Transforma dinámicamente el ícono entre añadir y calendario, indicando el cambio de estado en la aplicación.
- Implementa la clase AnimatedIcon de Material Design para realizar una metamorfosis suave entre los dos estados.
- La transformación se activa cuando el usuario interactúa con el botón para añadir una tarea nueva.
- Esta animación comunica visualmente el cambio de contexto de la interfaz, mejorando la comprensión y navegación del usuario.

