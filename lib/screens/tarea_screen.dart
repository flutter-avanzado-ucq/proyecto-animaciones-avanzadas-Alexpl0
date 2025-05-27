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
  bool _isAddIcon = true; // Variable para controlar el estado del icono

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
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
    _iconController.forward(from: 0); // Reinicia la animación del icono cuando se marca/desmarca una tarea
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleFabIcon() {
    // Animación 5: Función para alternar el icono del FAB entre añadir y calendario
    setState(() {
      _isAddIcon = !_isAddIcon;
    });
    
    if (_isAddIcon) {
      _iconController.reverse(); // Anima hacia el icono de añadir
    } else {
      _iconController.forward(); // Anima hacia el icono de calendario
    }
  }

  void _showAddTaskSheet() {
    _toggleFabIcon(); // Anima el icono al mostrar la hoja de añadir tarea
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddTaskSheet(onSubmit: (task) {
        _addTask(task);
        _toggleFabIcon(); // Vuelve al estado original del icono cuando se añade la tarea
      }),
    ).whenComplete(() {
      // Si el usuario cierra la hoja sin añadir tarea, restauramos el icono
      if (!_isAddIcon) {
        _toggleFabIcon();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: TaskCard(
                            title: task['title'],
                            isDone: task['done'],
                            onToggle: () => _toggleComplete(index),
                            onDelete: () => _removeTask(index),
                            iconRotation: _iconController,
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
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: AnimatedIcon(
          icon: AnimatedIcons.add_event, // Animación 4: Cambia el icono del botón entre añadir y calendario
          progress: _iconController, // Controlador que permite la transición fluida entre iconos
        ),
      ),
    );
  }
}
