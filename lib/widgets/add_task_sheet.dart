import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider_task/task_provider.dart';
import '../services/notification_service.dart'; // # 18 de Junio; se agregó servicio de notificaciones

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _controller = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() async { // # 18 de Junio; se agregó async para manejar notificaciones
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      Provider.of<TaskProvider>(context, listen: false).addTask(
        text,
        dueDate: _selectedDate, // # 18 de Junio; se mantuvo dueDate para consistencia
      );

      // # 18 de Junio; se agregó notificación inmediata al crear tarea
      await NotificationService.showImmediateNotification(
        title: 'Nueva tarea',
        body: 'Has agregado la tarea: $text',
        payload: 'Tarea: $text',
      );

      // # 18 de Junio; se agregó notificación programada para fechas establecidas
      if (_selectedDate != null) {
        await NotificationService.scheduleNotification(
          title: 'Recordatorio de tarea',
          body: 'No olvides: $text',
          scheduledDate: _selectedDate!,
          payload: 'Tarea programada: $text para ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
        );
      }

      Navigator.pop(context);
    }
  }

  Future<void> _pickDate() async { // # 18 de Junio; se cambió de '_selectDate' a '_pickDate'
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now, // # 18 de Junio; se cambió de '_selectedDate ?? DateTime.now()' a 'now'
      firstDate: now, // # 18 de Junio; se cambió de 'DateTime.now()' a 'now'
      lastDate: DateTime(now.year + 5), // # 18 de Junio; se cambió de 'DateTime.now().add(const Duration(days: 365))' a 'DateTime(now.year + 5)'
    );
    if (picked != null) { // # 18 de Junio; se removió la comparación '&& picked != _selectedDate'
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Agregar nueva tarea', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 12),
          // # 18 de Junio; se cambió de OutlinedButton.icon complejo a Row con ElevatedButton simple
          Row(
            children: [
              ElevatedButton(
                onPressed: _pickDate,
                child: const Text('Seleccionar fecha'),
              ),
              const SizedBox(width: 10),
              if (_selectedDate != null)
                Text('${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}')
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.check),
            label: const Text('Agregar tarea'),
            // # 18 de Junio; se removió el estilo 'minimumSize: const Size(double.infinity, 48)'
          ),
        ],
      ),
    );
  }
}
