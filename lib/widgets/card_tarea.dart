import 'dart:math';
import 'package:flutter/material.dart';
// 02 de Junio; se agregó import para formateo de fechas
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final bool isDone;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Animation<double> iconRotation;
  // 02 de Junio; se agregó propiedad para fecha de vencimiento
  final DateTime? date; 

  const TaskCard({
    super.key,
    required this.title,
    required this.isDone,
    required this.onToggle,
    required this.onDelete,
    required this.iconRotation,
    // 02 de Junio; se agregó parámetro requerido para fecha
    required this.date, 
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      // 02 de Junio; se agregó comentario explicativo para animación de opacidad
      opacity: isDone ? 0.6 : 1.0, // Animación 2: Cambia la opacidad cuando la tarea está completada
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // 02 de Junio; se agregó comentario explicativo para animación de color
          color: isDone ? Colors.lightBlueAccent.shade100 : Colors.white, // Animación 1: Cambia el color de fondo a azul cuando la tarea está completada
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ListTile(
          leading: GestureDetector(
            onTap: onToggle,
            child: AnimatedBuilder(
              animation: iconRotation,
              builder: (context, child) {
                return Transform.rotate(
                  // 02 de Junio; se agregó comentario explicativo y se corrigió la rotación
                  angle: isDone ? (1 - iconRotation.value) * pi : pi, 
                  // Animación 3: Rota el ícono 180 grados (pi radianes) cuando la tarea está completada
                  // Se arreglo el estado inicial para que terminara en la posición correcta
                  child: Icon(
                    isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                    // 02 de Junio; se cambió color de verde a azul para mantener coherencia
                    color: isDone ? Colors.blue : Colors.grey, // Cambiado a azul para mantener coherencia
                  ),
                );
              },
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              decoration: isDone ? TextDecoration.lineThrough : null,
              color: isDone ? Colors.black54 : Colors.black87,
            ),
          ),
          // 02 de Junio; se agregó subtitle para mostrar fecha de vencimiento
          subtitle: date != null
              ? Text(
                  'Vence en: ${date!.day}/${date!.month}/${date!.year}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )
              : null,
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
