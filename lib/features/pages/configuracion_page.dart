import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/services/auth_service.dart';
import 'package:flutter_application_1/features/auth/login_page.dart';

class ConfiguracionPage extends StatelessWidget {
  const ConfiguracionPage({super.key});

  void _cerrarSesion(BuildContext context) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sí, salir')),
        ],
      ),
    );

    if (confirmado == true) {
      await AuthService.logout();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const ListTile(
          leading: Icon(Icons.language),
          title: Text('Idioma'),
          subtitle: Text('Español'),
        ),
        const ListTile(
          leading: Icon(Icons.wifi_off),
          title: Text('Modo Offline'),
          subtitle: Text('Activado'),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Cerrar sesión'),
          onTap: () => _cerrarSesion(context),
        ),
      ],
    );
  }
}
