import 'package:hive/hive.dart';
import 'package:flutter_application_1/core/models/avistamiento.dart';

class AvistamientoService {
  static const String _boxName = 'avistamientos';

  static Future<void> registrarAvistamiento(Avistamiento avistamiento) async {
    final box = await Hive.openBox<Avistamiento>(_boxName);
    await box.put(avistamiento.id, avistamiento);
  }

  static Future<List<Avistamiento>> obtenerTodos() async {
    final box = await Hive.openBox<Avistamiento>(_boxName);
    return box.values.toList();
  }

  static Future<List<Avistamiento>> obtenerPorUsuario(String usuarioId) async {
    final box = await Hive.openBox<Avistamiento>(_boxName);
    return box.values.where((a) => a.usuarioId == usuarioId).toList();
  }
}
