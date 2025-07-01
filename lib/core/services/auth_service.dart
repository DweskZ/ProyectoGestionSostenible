import 'package:hive/hive.dart';
import 'package:flutter_application_1/core/models/usuario.dart';

class AuthService {
  static const String _usuariosBox = 'usuarios';
  static const String _authBox = 'auth';

  // Registrar usuario
  static Future<bool> registrarUsuario(Usuario usuario) async {
    final box = await Hive.openBox<Usuario>(_usuariosBox);
    final existe = box.values.any((u) => u.email == usuario.email);
    if (existe) return false;
    await box.put(usuario.id, usuario);
    return true;
  }

  // Login
  static Future<Usuario?> login(String email, String password) async {
    final box = await Hive.openBox<Usuario>(_usuariosBox);
    Usuario? usuario;
    try {
      usuario = box.values.firstWhere(
        (u) => u.email == email && u.password == password,
      );
    } catch (e) {
      usuario = null; 
    }

    if (usuario != null) {
      final authBox = await Hive.openBox<Usuario>(_authBox);
      await authBox.clear();
      await authBox.put('usuario', Usuario(
      id: usuario.id,
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      email: usuario.email,
      telefono: usuario.telefono,
      password: usuario.password,
      rol: usuario.rol,
      cedula: usuario.cedula,
      experiencia: usuario.experiencia,
      especialidades: usuario.especialidades,
      bio: usuario.bio,
      fotoPerfil: usuario.fotoPerfil,
    ));
    
      return usuario;
    }
    return null;
  }

  // Obtener usuario actual
  static Future<Usuario?> usuarioActual() async {
    final authBox = await Hive.openBox<Usuario>(_authBox);
    return authBox.get('usuario');
  }

  // Cerrar sesión
  static Future<void> logout() async {
    final authBox = await Hive.openBox<Usuario>(_authBox);
    await authBox.clear();
  }
}
