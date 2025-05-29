import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/card_tarea.dart';
import '../widgets/header.dart';
import '../widgets/add_task_sheet.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _tasks = [];
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void _addTask(String task) {
    setState(() {
      _tasks.insert(0, {'title': task, 'done': false});
    });
  }

  void _toggleComplete(int index) {
    // 28 de Mayo, agregada validación de índices para prevenir errores de rango al marcar tareas
    if (index >= 0 && index < _tasks.length) {
      setState(() {
        _tasks[index]['done'] = !_tasks[index]['done'];
      });
      _iconController.forward(from: 0);
    }
  }

  void _removeTask(int index) {
    // 28 de Mayo, agregada validación de índices para prevenir errores al eliminar tareas
    if (index >= 0 && index < _tasks.length) {
      setState(() {
        _tasks.removeAt(index);
      });
    }
  }

  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddTaskSheet(onSubmit: _addTask),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              // 28 de Mayo, AnimationLimiter previene que las animaciones se repitan durante el scroll
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    // 28 de Mayo, configuración de animaciones escalonadas para entrada suave de elementos
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      // 28 de Mayo, animación de deslizamiento vertical desde abajo hacia arriba
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        // 28 de Mayo, animación de desvanecimiento para entrada gradual de elementos
                        child: FadeInAnimation(
                          // 28 de Mayo, widget Dismissible permite deslizar tareas para eliminarlas con gesto
                          child: Dismissible(
                            // 28 de Mayo, clave única basada en el título para identificar cada tarea
                            key: ValueKey(task['title']),
                            // 28 de Mayo, solo permite deslizar de derecha a izquierda para eliminar
                            direction: DismissDirection.endToStart,
                            // 28 de Mayo, función que se ejecuta cuando se completa el gesto de deslizar
                            onDismissed: (_) {
                              final removedTask = task;
                              _removeTask(index);
                              // 28 de Mayo, SnackBar para confirmar eliminación de tarea con mensaje personalizado
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${removedTask['title']} eliminado',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            // 28 de Mayo, fondo rojo con icono de eliminar que aparece al deslizar
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                // 28 de Mayo, color rojo para indicar acción destructiva
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: TaskCard(
                              title: task['title'],
                              isDone: task['done'],
                              onToggle: () => _toggleComplete(index),
                              onDelete: () => _removeTask(index),
                              iconRotation: _iconController,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskSheet,
        // 28 de Mayo, cambio de color a púrpura profundo para mejor contraste visual
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: AnimatedIcon(
          // 28 de Mayo, cambio de icono a search_ellipsis para transición entre búsqueda y puntos suspensivos
          icon: AnimatedIcons.search_ellipsis,
          progress: _iconController,
        ),
      ),
    );
  }
}
