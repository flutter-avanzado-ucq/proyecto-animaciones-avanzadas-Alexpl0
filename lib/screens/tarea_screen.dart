import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/card_tarea.dart';
import '../widgets/header.dart';
import '../widgets/add_task_sheet.dart';

// 02 de Junio; se agregaron imports para provider y task_provider
import 'package:provider/provider.dart';
import '../provider_task/task_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  // 02 de Junio; se eliminó la lista local de tareas para usar provider
  // final List<Map<String, dynamic>> _tasks = [];
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

  // 02 de Junio; se eliminaron métodos locales de manejo de tareas
  // void _addTask(String task) {
  //   setState(() {
  //     _tasks.insert(0, {'title': task, 'done': false});
  //   });
  // }

  // void _toggleComplete(int index) {
  //   if (index >= 0 && index < _tasks.length) {
  //     setState(() {
  //       _tasks[index]['done'] = !_tasks[index]['done'];
  //     });
  //     _iconController.forward(from: 0);
  //   }
  // }

  // void _removeTask(int index) {
  //   if (index >= 0 && index < _tasks.length) {
  //     setState(() {
  //       _tasks.removeAt(index);
  //     });
  //   }
  // }

  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      // 02 de Junio; se cambió el builder para usar AddTaskSheet sin parámetros
      builder: (_) => const AddTaskSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 02 de Junio; se agregó el uso del provider para acceso a las tareas
    final taskProvider = context.watch<TaskProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              // 02 de Junio; se agregó comentario sobre AnimationLimiter
              // AnimationLimiter previene que las animaciones se repitan durante el scroll
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  // 02 de Junio; se cambió para usar taskProvider.tasks.length
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (context, index) {
                    // 02 de Junio; se cambió para usar taskProvider.tasks[index]
                    final task = taskProvider.tasks[index];
                    // 02 de Junio; se agregó comentario sobre configuración de animaciones escalonadas
                    // configuración de animaciones escalonadas para entrada suave de elementos
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      // 02 de Junio; se agregó comentario sobre animación de deslizamiento
                      // animación de deslizamiento vertical desde abajo hacia arriba
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        // 02 de Junio; se agregó comentario sobre animación de desvanecimiento
                        // animación de desvanecimiento para entrada gradual de elementos
                        child: FadeInAnimation(
                          // 02 de Junio; se agregó comentario sobre widget Dismissible
                          // widget Dismissible permite deslizar tareas para eliminarlas con gesto
                          child: Dismissible(
                            // 02 de Junio; se cambió para usar task.title en lugar de task['title']
                            // clave única basada en el título para identificar cada tarea
                            key: ValueKey(task.title),
                            // 02 de Junio; se agregó comentario sobre dirección de deslizamiento
                            // solo permite deslizar de derecha a izquierda para eliminar
                            direction: DismissDirection.endToStart,
                            // 02 de Junio; se cambió para usar taskProvider.removeTask(index)
                            // función que se ejecuta cuando se completa el gesto de deslizar
                            onDismissed: (_) => taskProvider.removeTask(index),
                            // 02 de Junio; se agregó comentario sobre el fondo del Dismissible
                            // fondo rojo con icono de eliminar que aparece al deslizar
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
                                // 02 de Junio; se agregó comentario sobre color rojo
                                // color rojo para indicar acción destructiva
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: TaskCard(
                              // 02 de Junio; se cambió para usar task.title en lugar de task['title']
                              title: task.title,
                              // 02 de Junio; se cambió para usar task.done en lugar de task['done']
                              isDone: task.done,
                              // 02 de Junio; se agregó la propiedad date
                              date: task.date,
                              // 02 de Junio; se cambió para usar taskProvider.toggleTask(index)
                              onToggle: () {
                                taskProvider.toggleTask(index);
                                _iconController.forward(from: 0.0);
                              },
                              // 02 de Junio; se cambió para usar taskProvider.removeTask(index)
                              onDelete: () => taskProvider.removeTask(index),
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
        // 02 de Junio; se cambió el color de púrpura profundo a azul acento
        // cambio de color a azul acento para mejor contraste visual
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: AnimatedIcon(
          // 02 de Junio; se cambió el icono de search_ellipsis a menu_home  
          // cambio de icono a menu_home para transición entre menú y casa
          icon: AnimatedIcons.menu_home,
          progress: _iconController,
        ),
      ),
    );
  }
}
