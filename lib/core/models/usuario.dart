import 'package:hive/hive.dart';

part 'usuario.g.dart';

@HiveType(typeId: 0)
class Usuario extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String nombre;
  @HiveField(2)
  String apellido;
  @HiveField(3)
  String email;
  @HiveField(4)
  String telefono;
  @HiveField(5)
  String password;
  @HiveField(6)
  String rol; // 'turista' o 'guia'
  @HiveField(7)
  String cedula;

  // Solo para guía (deja en null si es turista)

  @HiveField(8)
  String? experiencia;
  @HiveField(9)
  List<String>? especialidades;
  @HiveField(10)
  String? bio;
  @HiveField(11)
  String? fotoPerfil;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
    required this.password,
    required this.rol,
    required this.cedula,
    this.experiencia,
    this.especialidades,
    this.bio,
    this.fotoPerfil,
  });
}
