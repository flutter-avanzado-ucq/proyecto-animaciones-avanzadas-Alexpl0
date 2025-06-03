import 'package:flutter/material.dart';
//02 de Junio; se agregó import de provider para manejo de estado
import 'package:provider/provider.dart';
//02 de Junio; se agregó import del task_provider
import '../provider_task/task_provider.dart';

class AddTaskSheet extends StatefulWidget {
  //02 de Junio; se eliminó el parámetro onSubmit del constructor
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _controller = TextEditingController();
  //02 de Junio; se agregó variable para manejar fecha seleccionada
  DateTime? _selectedDate;

  //02 de Junio; se agregó método dispose para liberar recursos
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //02 de Junio; se agregó función para mostrar selector de fecha
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      //02 de Junio; se cambió de widget.onSubmit a Provider para agregar tarea
      Provider.of<TaskProvider>(context, listen: false).addTask(
        text,
        date: _selectedDate,
      );
      Navigator.pop(context);
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
          //02 de Junio; se agregó botón para seleccionar fecha de vencimiento
          OutlinedButton.icon(
            onPressed: _selectDate,
            icon: const Icon(Icons.calendar_today),
            label: Text(
              _selectedDate == null 
                ? 'Seleccionar fecha de vencimiento' 
                : 'Vence: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.check),
            label: const Text('Agregar tarea'),
            //02 de Junio; se agregó estilo para hacer el botón de ancho completo
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ],
      ),
    );
  }
}
