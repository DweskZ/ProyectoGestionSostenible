import 'package:hive/hive.dart';

part 'avistamiento.g.dart';

@HiveType(typeId: 5)
class Avistamiento extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String aveId;

  @HiveField(2)
  String usuarioId;

  @HiveField(3)
  DateTime fecha;

  @HiveField(4)
  int cantidad;

  @HiveField(5)
  String? notas;

  Avistamiento({
    required this.id,
    required this.aveId,
    required this.usuarioId,
    required this.fecha,
    required this.cantidad,
    this.notas,
  });
}
