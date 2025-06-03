import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0062E6), Color(0xFF33AEFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white70,
            child: Icon(
              Icons.person,
              color: Color(0xFF0062E6),
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hola, Alex 👋',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                'Estas son tus tareas para hoy',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
