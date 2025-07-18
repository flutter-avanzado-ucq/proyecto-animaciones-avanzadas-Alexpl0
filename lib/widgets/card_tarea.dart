import 'dart:math';
import 'package:flutter/material.dart';
// 04 de junio - se agregó import para el EditTaskSheet
import 'edit_task_sheet.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final bool isDone;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Animation<double> iconRotation;
  final DateTime? date; 
  // 04 de junio - se agregó propiedad index para identificar la tarea
  final int index; 

  const TaskCard({
    super.key,
    required this.title,
    required this.isDone,
    required this.onToggle,
    required this.onDelete,
    required this.iconRotation,
    required this.date, 
    // 04 de junio - se agregó parámetro requerido index
    required this.index,
    });


  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: isDone ? 0.6 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDone ? Colors.lightBlueAccent.shade100 : Colors.white,
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
                  angle: isDone ? (1 - iconRotation.value) * pi : pi, 
                  child: Icon(
                    isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isDone ? Colors.blue : Colors.grey,
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
          subtitle: date != null
              ? Text(
                  'Vence en: ${date!.day}/${date!.month}/${date!.year}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )
              : null,

          // 04 de junio - se cambió trailing de un solo botón a Row con dos botones (editar y eliminar)
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 04 de junio - se agregó botón de editar con modal bottom sheet
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blueAccent),
                onPressed: () {
                  showModalBottomSheet(
                    context: context, 
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (_) => EditTaskSheet(index: index)
                    );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}