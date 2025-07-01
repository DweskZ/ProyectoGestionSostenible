import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/aves/registro_avistamiento_page.dart';

class AvesPage extends StatelessWidget {
  const AvesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avistamientos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Registra un avistamiento',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegistroAvistamientoPage()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Agregar Ave'),
            ),
          ],
        ),
      ),
    );
  }
}
