import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_application_1/core/models/usuario.dart';
import 'package:flutter_application_1/core/services/auth_service.dart';
import 'login_page.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cedulaController = TextEditingController();
  String _rol = 'turista';
  String? _error;

  Future<void> _registrar() async {
    if (_formKey.currentState!.validate()) {
      final nuevoUsuario = Usuario(
        id: const Uuid().v4(),
        nombre: _nombreController.text.trim(),
        apellido: _apellidoController.text.trim(),
        email: _emailController.text.trim(),
        telefono: _telefonoController.text.trim(),
        password: _passwordController.text.trim(),
        rol: _rol,
        cedula: _cedulaController.text.trim(),
      );

      final creado = await AuthService.registrarUsuario(nuevoUsuario);
      if (creado) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      } else {
        setState(() {
          _error = 'Ya existe un usuario con ese correo.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text('Crear Cuenta',
                style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: colors.primary)),
            const SizedBox(height: 16),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _campo('Nombre', _nombreController, Icons.person),
                  _campo('Apellido', _apellidoController, Icons.person_outline),
                  _campo('Email', _emailController, Icons.email),
                  _campo('Teléfono', _telefonoController, Icons.phone),
                  _campo('Cédula', _cedulaController, Icons.credit_card),
                  _campo('Contraseña', _passwordController, Icons.lock,
                      obscure: true),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _rol,
                    decoration: const InputDecoration(
                      labelText: 'Rol',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'turista', child: Text('Turista')),
                      DropdownMenuItem(value: 'guia', child: Text('Guía')),
                    ],
                    onChanged: (val) => setState(() => _rol = val ?? 'turista'),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _registrar,
                      child: const Text('Registrarse'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo(String label, TextEditingController controller, IconData icon,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (val) =>
            val == null || val.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }
}
