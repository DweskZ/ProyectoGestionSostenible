import 'package:hive/hive.dart';

part 'tour.g.dart';

@HiveType(typeId: 1)
class Tour extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String nombre;
  @HiveField(2)
  String descripcion;
  @HiveField(3)
  DateTime fecha;
  @HiveField(4)
  String guiaId; // id del guía (usuario)
  @HiveField(5)
  List<String> participantesIds; // ids de turistas

  // Campos para ubicación
  @HiveField(6)
  double? latitud;
  @HiveField(7)
  double? longitud;
  @HiveField(8)
  String? direccion; // Calle, sector, o referencia (opcional)

  // Campo para WhatsApp
  @HiveField(9)
  String? whatsappGrupoUrl;

  Tour({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.fecha,
    required this.guiaId,
    required this.participantesIds,
    this.latitud,
    this.longitud,
    this.direccion,
    this.whatsappGrupoUrl,
  });
}